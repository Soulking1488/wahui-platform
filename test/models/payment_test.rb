require "test_helper"

class PaymentTest < ActiveSupport::TestCase
  setup do
    @player = User.create!(email: "payment-player@example.com", password: "Password123!", role: "player")
    @payment = @player.payments.build(
      wallet: @player.wallet,
      provider: "doku",
      merchant_reference: "WAHUI-PAY-001",
      idempotency_key: "payment-idempotency-001",
      amount: 25.50,
      currency: "MYR"
    )
  end

  test "accepts a pending payment with provider-neutral fields" do
    assert_predicate @payment, :valid?
    assert_predicate @payment, :pending?
  end

  test "requires an uppercase ISO currency code" do
    @payment.currency = "myr"

    assert_not @payment.valid?
    assert_includes @payment.errors[:currency], "is invalid"
  end

  test "can be used as a ledger transaction reference" do
    @payment.save!

    transaction = @player.wallet.credit!(25.50, transaction_type: :deposit, reference: @payment)

    assert_equal @payment, transaction.reload.reference
  end
end