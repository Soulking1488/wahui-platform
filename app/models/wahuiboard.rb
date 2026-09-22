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
  validates :status, presence: true
  validates :house_bet_amount, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validate :timeline_is_ordered
  validate :pantun_clues_are_complete

  scope :drafts, -> { where(status: :draft) }

  def draft?
    status == "draft"
  end

  def pantun_lines
    [clue_1, clue_2, clue_3, clue_4].compact.map(&:strip).reject(&:blank?)
  end

  def pantun_lines=(values)
    values = Array(values).first(4)
    self.clue_1, self.clue_2, self.clue_3, self.clue_4 = values
  end

  def settlement_estimate
    return 0.to_d if status.blank?

    losing_pool = bets.where.not(board_id: board_id).sum(:amount).to_d
    house_pool = house_bet_amount.to_d
    losing_pool + house_pool
  end

  private

  def timeline_is_ordered
    if opens_at && betting_closing_time && betting_closing_time <= opens_at
      errors.add(:betting_closing_time, "must be after the opening time")
    end

    if betting_closing_time && announcement_time && announcement_time <= betting_closing_time
      errors.add(:announcement_time, "must be after the betting closing time")
    end
  end

  def pantun_clues_are_complete
    return if pantun_lines.length >= 4

    errors.add(:base, "must include exactly 4 pantun clue lines")
  end
end
