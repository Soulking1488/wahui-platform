require "test_helper"

class BetTest < ActiveSupport::TestCase
  setup do
    @board = Board.create!(name: "KURA-KURA", active: true)
    @round = Wahuiboard.create!(
      title: "Open Round",
      public_number: 401,
      board: @board,
      status: "open",
      opens_at: 30.minutes.ago,
      betting_closing_time: 1.hour.from_now,
      announcement_time: 2.hours.from_now,
      house_bet_amount: 0,
      clue_1: "A",
      clue_2: "B",
      clue_3: "C",
      clue_4: "D"
    )
    @player = User.create!(email: "bet-player@example.com", password: "Password123!", role: "player")
  end

  test "rejects a bet that exceeds the player's wallet balance" do
    bet = @player.bets.build(wahuiboard: @round, board: @board, amount: 1)

    assert_not bet.valid?
    assert_includes bet.errors[:amount], "exceeds wallet balance"
  end

  test "accepts a bet within the player's wallet balance" do
    @player.wallet.credit!(10, transaction_type: :deposit)
    bet = @player.bets.build(wahuiboard: @round, board: @board, amount: 10)

    assert_predicate bet, :valid?
  end
end
