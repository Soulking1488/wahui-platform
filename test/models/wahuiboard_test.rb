require "test_helper"

class WahuiboardTest < ActiveSupport::TestCase
  test "a draft round with valid timing and four clue lines is valid" do
    board = Board.create!(name: "KURA-KURA", active: true)

    round = Wahuiboard.new(
      title: "Draft Round 101",
      public_number: 101,
      board: board,
      status: :draft,
      opens_at: 1.day.from_now,
      betting_closing_time: 1.day.from_now + 30.minutes,
      announcement_time: 1.day.from_now + 2.hours,
      house_bet_amount: 0,
      clue_1: "Di tepi sungai menunggu angin",
      clue_2: "Bawa hati menantikan tuan",
      clue_3: "Bersama kawan meredah hari",
      clue_4: "Mencari jalan pulang ke rumah"
    )

    assert round.valid?
  end

  test "round requires exactly four pantun clue lines" do
    board = Board.create!(name: "IKAN BESAR", active: true)

    round = Wahuiboard.new(
      title: "Incomplete Pantun",
      public_number: 102,
      board: board,
      status: :draft,
      opens_at: 1.day.from_now,
      betting_closing_time: 1.day.from_now + 30.minutes,
      announcement_time: 1.day.from_now + 2.hours,
      clue_1: "Only first line"
    )

    assert_not round.valid?
    assert_includes round.errors[:base], "must include exactly 4 pantun clue lines"
  end

  test "announcement time must be after the betting closing time" do
    board = Board.create!(name: "IKAN BESAR", active: true)

    round = Wahuiboard.new(
      title: "Broken Round",
      public_number: 103,
      board: board,
      status: :draft,
      opens_at: 1.day.from_now,
      betting_closing_time: 1.day.from_now + 2.hours,
      announcement_time: 1.day.from_now + 1.hour,
      clue_1: "A",
      clue_2: "B",
      clue_3: "C",
      clue_4: "D"
    )

    assert_not round.valid?
    assert_includes round.errors[:announcement_time], "must be after the betting closing time"
  end
end
