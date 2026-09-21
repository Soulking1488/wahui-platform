class Wahuiboard < ApplicationRecord
  belongs_to :board
  belongs_to :house_bet_board, class_name: "Board", optional: true
  has_many :synonyms, dependent: :nullify
  has_many :bets, dependent: :restrict_with_error

  enum :status, {
    draft: "draft",
    scheduled: "scheduled",
    open: "open",
    closed: "closed",
    announced: "announced",
    settled: "settled",
    cancelled: "cancelled"
  }, default: :draft

  validates :title, presence: true
  validates :public_number, presence: true, uniqueness: true
  validates :house_bet_amount, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validate :timeline_is_ordered

  private

  def timeline_is_ordered
    if opens_at && betting_closing_time && betting_closing_time <= opens_at
      errors.add(:betting_closing_time, "must be after the opening time")
    end

    if betting_closing_time && announcement_time && announcement_time <= betting_closing_time
      errors.add(:announcement_time, "must be after the betting closing time")
    end
  end
end
