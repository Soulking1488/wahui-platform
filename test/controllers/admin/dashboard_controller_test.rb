require "test_helper"

class Admin::DashboardControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @admin = User.create!(email: "dashboard@example.com", password: "Password123!", role: "admin")
    sign_in @admin
    @board = Board.create!(name: "KURA-KURA", active: true)
    @round = Wahuiboard.create!(
      title: "Draft Round",
      public_number: 301,
      board: @board,
      status: "draft",
      opens_at: 1.day.from_now,
      betting_closing_time: 1.day.from_now + 30.minutes,
      announcement_time: 1.day.from_now + 2.hours,
      house_bet_amount: 50,
      clue_1: "A",
      clue_2: "B",
      clue_3: "C",
      clue_4: "D"
    )
    @open_round = Wahuiboard.create!(
      title: "Live Round",
      public_number: 302,
      board: @board,
      status: "open",
      opens_at: 30.minutes.ago,
      betting_closing_time: 1.hour.from_now,
      announcement_time: 2.hours.from_now,
      house_bet_amount: 25,
      clue_1: "A",
      clue_2: "B",
      clue_3: "C",
      clue_4: "D"
    )
    @user = User.create!(email: "player@example.com", password: "Password123!", role: "player")
    @user.wallet.credit!(500, transaction_type: :deposit)
    @user.bets.create!(wahuiboard: @open_round, board: @board, amount: 100)
  end

  test "dashboard exposes round summary widgets" do
    @announced_round = Wahuiboard.create!(
      title: "Announced Round",
      public_number: 303,
      board: @board,
      status: "open",
      opens_at: 3.hours.ago,
      betting_closing_time: 1.hour.from_now,
      announcement_time: 2.hours.from_now,
      house_bet_amount: 50,
      clue_1: "A",
      clue_2: "B",
      clue_3: "C",
      clue_4: "D"
    )

    @announced_round.bets.create!(user: @user, board: @board, amount: 200)
    @announced_round.bets.create!(user: @user, board: Board.create!(name: "IKAN BESAR", active: true), amount: 150)
    @announced_round.update!(status: "announced", betting_closing_time: 1.hour.ago, announcement_time: 30.minutes.ago, announced_at: 10.minutes.ago)

    get admin_root_path

    assert_response :success
    assert_includes response.body, "Upcoming rounds"
    assert_includes response.body, "Ongoing rounds"
    assert_includes response.body, "Settlement due"
    assert_includes response.body, "RM 200.00"
  end
end
