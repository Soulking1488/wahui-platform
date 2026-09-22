require "test_helper"

class Payments::CreateCheckoutTest < ActiveSupport::TestCase
  class FakeGateway
    def initialize(credentials: nil); end

    def create_checkout(payment, callback_url:, now:)
      payment.update!(provider_payment_id: "doku-payment-001", checkout_url: "https://sandbox.doku.com/checkout/001")
    end
  end

  setup do
    @player = User.create!(email: "checkout-player@example.com", password: "Password123!", role: "player")
  end

  test "creates a pending payment and delegates checkout creation" do
    payment = Payments::CreateCheckout.call(
      user: @player,
      amount: 20,
      currency: "MYR",
      callback_url: "https://wahui.example/payments/callback",
      credentials: {},
      now: Time.utc(2026, 9, 22, 0),
      gateway_class: FakeGateway
    )

    assert_equal "doku", payment.provider
    assert_equal "pending", payment.status
    assert_equal "doku-payment-001", payment.provider_payment_id
    assert_equal "https://sandbox.doku.com/checkout/001", payment.checkout_url
    assert_equal 30.minutes, payment.expired_at - Time.utc(2026, 9, 22, 0)
  end
end