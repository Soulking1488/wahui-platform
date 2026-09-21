class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :wahuiboard
  belongs_to :board

  enum :status, {
    placed: "placed",
    cancelled: "cancelled",
    won: "won",
    lost: "lost",
    refunded: "refunded"
  }, default: :placed

  before_validation :set_placed_at, on: :create

  validates :amount, numericality: { greater_than: 0 }
  validates :placed_at, presence: true
  validate :round_accepts_bets
  validate :board_is_active

  scope :active, -> { where(status: :placed) }

  private

  def set_placed_at
    self.placed_at ||= Time.current
  end

  def round_accepts_bets
    return unless wahuiboard

    unless wahuiboard.open?
      errors.add(:wahuiboard, "is not open for betting")
    end

    if wahuiboard.betting_closing_time && wahuiboard.betting_closing_time <= Time.current
      errors.add(:wahuiboard, "betting has closed")
    end
  end

  def board_is_active
    return unless board

    errors.add(:board, "is not active") unless board.active?
  end
end
