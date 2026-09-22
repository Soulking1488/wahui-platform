require "securerandom"

module Payments
  class CreateCheckout
    def self.call(user:, amount:, currency:, callback_url:, credentials: nil, now: Time.current, gateway_class: Payments::Providers::Doku::Gateway)
      new(user:, amount:, currency:, callback_url:, credentials:, now:, gateway_class:).call
    end

    def initialize(user:, amount:, currency:, callback_url:, credentials:, now:, gateway_class:)
      @user = user
      @amount = amount
      @currency = currency
      @callback_url = callback_url
      @credentials = credentials || Payments::Providers::Doku::Credentials.call
      @now = now
      @gateway_class = gateway_class
    end

    def call
      payment = @user.payments.create!(
        wallet: @user.wallet,
        provider: "doku",
        merchant_reference: merchant_reference,
        idempotency_key: SecureRandom.uuid,
        amount: @amount,
        currency: @currency,
        expired_at: @now + 30.minutes
      )

      @gateway_class.new(credentials: @credentials).create_checkout(
        payment,
        callback_url: @callback_url,
        now: @now
      )

      payment.reload
    end

    private

    def merchant_reference
      "WAHUI-#{SecureRandom.hex(10).upcase}"
    end
  end
end