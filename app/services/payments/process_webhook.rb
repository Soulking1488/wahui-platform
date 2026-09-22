require "json"

module Payments
  class ProcessWebhook
    def self.call(provider:, raw_body:, gateway:, path:)
      new(provider:, raw_body:, gateway:, path:).call
    end

    def initialize(provider:, raw_body:, gateway:, path:)
      @provider = provider
      @raw_body = raw_body
      @gateway = gateway
      @path = path
    end

    def call
      @gateway.verify_webhook!(@raw_body, headers, path: @path)
      payload = JSON.parse(@raw_body)
      payment = Payment.find_by!(provider: @provider, merchant_reference: payload.dig("order", "invoice_number"))
      event_id = payload["id"] || payload.dig("payment", "id") || payload.dig("order", "invoice_number")
      raise ArgumentError, "DOKU webhook has no event ID" if event_id.blank?

      PaymentEvent.transaction do
        payment.with_lock do
          event = payment.payment_events.find_or_initialize_by(provider_event_id: event_id)
          return payment if event.persisted?

          event.assign_attributes(
            provider: @provider,
            event_type: payload.dig("payment", "status"),
            payload: JSON.generate(payload)
          )
          event.save!
          apply_status!(payment, payload.dig("payment", "status"))
        end
      end

      payment.reload
    end

    attr_writer :headers

    private

    def headers
      @headers || {}
    end

    def apply_status!(payment, status)
      case status.to_s.upcase
      when "COMPLETED", "SUCCESS", "PAID"
        return if payment.paid?

        payment.update!(status: "paid", paid_at: Time.current)
        payment.wallet.credit!(payment.amount, transaction_type: :deposit, reference: payment)
      when "FAILED", "CANCELLED"
        payment.update!(status: "failed", failed_at: Time.current) unless payment.paid?
      when "EXPIRED"
        payment.update!(status: "expired", expired_at: Time.current) unless payment.paid?
      end
    end
  end
end