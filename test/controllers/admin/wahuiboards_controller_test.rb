require "test_helper"

class Admin::WahuiboardsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @board = Board.create!(name: "KURA-KURA", active: true)
    @admin = User.create!(email: "admin@example.com", password: "Password123!", role: "admin")
    sign_in @admin
  end

  test "admin can create a draft round" do
    post admin_wahuiboards_path, params: {
      wahuiboard: {
        title: "Evening Draft",
        public_number: 201,
        board_id: @board.id,
        status: "draft",
        opens_at: 1.day.from_now,
        betting_closing_time: 1.day.from_now + 30.minutes,
        announcement_time: 1.day.from_now + 2.hours,
        house_bet_amount: 100.00,
        clue_1: "Awal pagi menunggu embun",
        clue_2: "Membawa hati ke tepi sawah",
        clue_3: "Mencari jalan menuju rumah",
        clue_4: "Menanti sang juara kembali"
      }
    }

    assert_redirected_to admin_wahuiboard_path(Wahuiboard.last)
    assert_equal "draft", Wahuiboard.last.status
  end
end
