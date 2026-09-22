require "json"
require "net/http"
require "securerandom"

module Payments
  module Providers
    module Doku
      class Gateway
        API_VERSION = "arabica.2025-12-01"
        PATH = "/v3/checkouts"
        BASE_URLS = {
          "sandbox" => "https://api-sandbox.doku.com",
          "production" => "https://api.doku.com"
        }.freeze

        class RequestError < StandardError
          attr_reader :status, :body

          def initialize(status, body)
            @status = status
            @body = body
            super("DOKU request failed with HTTP #{status}")
          end
        end

        def initialize(credentials:, http_client: Net::HTTP)
          @credentials = credentials.symbolize_keys
          @http_client = http_client
        end

        def create_checkout(payment, callback_url:, callback_url_result: callback_url, now: Time.current)
          body = JSON.generate(
            id: SecureRandom.uuid,
            order: {
              amount: payment.amount.to_d.to_f,
              invoice_number: payment.merchant_reference,
              currency: payment.currency,
              expired_at: (payment.expired_at || 30.minutes.from_now).utc.iso8601
            },
            checkout_experience: {
              callback_url:,
              callback_url_result:
            },
            customer: {
              name: payment.user.email,
              email: payment.user.email
            }
          )
          headers = request_headers(path: PATH, body:, idempotency_key: payment.idempotency_key, now:)
          response = post(PATH, body, headers)
          response_body = parse_response(response.body)

          payment.update!(
            provider_payment_id: response_body["id"],
            checkout_url: response_body.dig("checkout_experience", "checkout_url") || response_body.dig("payment", "checkout_url"),
            raw_response: JSON.generate(response_body)
          )

          response_body
        end

        def verify_webhook!(raw_body, headers, path:)
          expected = Signature.generate(
            client_id: headers.fetch("Client-Id"),
            timestamp: headers.fetch("Request-Timestamp"),
            path:,
            body: raw_body,
            secret_key: @credentials.fetch(:secret_key)
          )

          raise RequestError.new(401, "Invalid DOKU webhook signature") unless Signature.secure_compare(expected, headers.fetch("Signature"))

          true
        rescue KeyError
          raise RequestError.new(401, "Missing DOKU webhook signature header")
        end

        private

        def request_headers(path:, body:, idempotency_key:, now:)
          timestamp = now.utc.iso8601

          {
            "Authorization" => "Basic #{Base64.strict_encode64("#{@credentials.fetch(:api_key)}:")}",
            "Client-Id" => @credentials.fetch(:client_id),
            "Request-Timestamp" => timestamp,
            "Idempotency-Id" => idempotency_key,
            "Signature" => Signature.generate(
              client_id: @credentials.fetch(:client_id),
              timestamp:,
              path:,
              body:,
              secret_key: @credentials.fetch(:secret_key)
            ),
            "API-Version" => API_VERSION,
            "Content-Type" => "application/json"
          }
        end

        def post(path, body, headers)
          uri = URI.join(base_url, path)
          request = Net::HTTP::Post.new(uri)
          headers.each { |name, value| request[name] = value }
          request.body = body

          response = @http_client.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
            http.request(request)
          end
          raise RequestError.new(response.code.to_i, response.body) unless response.is_a?(Net::HTTPSuccess)

          response
        end

        def parse_response(body)
          JSON.parse(body)
        rescue JSON::ParserError
          raise RequestError.new(502, body)
        end

        def base_url
          @credentials[:base_url] || BASE_URLS.fetch(@credentials.fetch(:environment, "sandbox"))
        end
      end
    end
  end
end