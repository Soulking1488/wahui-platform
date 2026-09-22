module Payments
  module Webhooks
    class DokuController < ActionController::API
      def create
        raw_body = request.raw_post
        gateway = Payments::Providers::Doku::Gateway.new(credentials: doku_credentials)
        processor = Payments::ProcessWebhook.new(
          provider: "doku",
          raw_body:,
          gateway:,
          path: request.path
        )
        processor.headers = doku_headers
        payment = processor.call

        render json: { status: "processed", payment_id: payment.id }
      rescue Payments::Providers::Doku::Gateway::RequestError => error
        render json: { error: error.message }, status: error.status
      rescue ActiveRecord::RecordNotFound, ArgumentError => error
        render json: { error: error.message }, status: :unprocessable_entity
      end

      private

      def doku_headers
        {
          "Client-Id" => request.headers["Client-Id"],
          "Request-Timestamp" => request.headers["Request-Timestamp"],
          "Signature" => request.headers["Signature"]
        }
      end

      def doku_credentials
        Payments::Providers::Doku::Credentials.call
      end
    end
  end
end