require "test_helper"

class Payments::ProcessWebhookTest < ActiveSupport::TestCase
  class VerifiedGateway
    def verify_webhook!(*); true; end
  end

  setup do
    @player = User.create!(email: "webhook-player@example.com", password: "Password123!", role: "player")
    @payment = @player.payments.create!(
      wallet: @player.wallet,
      provider: "doku",
      merchant_reference: "WAHUI-WEBHOOK-001",
      idempotency_key: "webhook-idempotency-001",
      amount: 15,
      currency: "MYR"
    )
    @raw_body = JSON.generate(
      id: "doku-event-001",
      order: { invoice_number: @payment.merchant_reference },
      payment: { status: "COMPLETED" }
    )
  end

  test "credits the wallet once for a repeated successful webhook" do
    processor = Payments::ProcessWebhook.new(
      provider: "doku",
      raw_body: @raw_body,
      gateway: VerifiedGateway.new,
      path: "/webhooks/doku"
    )

    processor.call
    processor.call

    assert_equal 15.to_d, @player.wallet.reload.balance
    assert_equal 1, @payment.reload.payment_events.count
    assert_equal 1, @payment.wahui_transactions.count
    assert_equal "paid", @payment.status
  end
end