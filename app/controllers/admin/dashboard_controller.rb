module Admin
  class DashboardController < BaseController
    def index
      @total_users = User.count
      @total_boards = Board.count rescue 0
      @total_transactions = WahuiTransaction.count rescue 0
    end
  end
end
