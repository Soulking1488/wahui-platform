require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "player creation provisions one zero-balance wallet" do
    player = User.create!(email: "player-wallet@example.com", password: "Password123!", role: "player")

    assert_not_nil player.wallet
    assert_equal 0.to_d, player.wallet.balance
    assert_equal 1, Wallet.where(user: player).count
  end

  test "non-player creation does not provision a player wallet" do
    admin = User.create!(email: "admin-wallet@example.com", password: "Password123!", role: "admin")

    assert_nil admin.wallet
  end
end
