module Admin
  class DashboardController < BaseController
    def index
      @total_users = User.count
      @total_boards = Board.count rescue 0
      @total_transactions = WahuiTransaction.count rescue 0

      @upcoming_rounds = Wahuiboard.includes(:board).where(status: [:draft, :scheduled]).order(:opens_at).limit(5)
      @ongoing_rounds = Wahuiboard.includes(:board, :bets).where(status: :open).order(:opens_at).limit(5)
      @settlement_due = Wahuiboard.includes(:board, :bets).where(status: [:announced, :settled]).order(announced_at: :desc).limit(5).map do |round|
        { round: round, settlement_amount: round.settlement_estimate }
      end
    end
  end
end
