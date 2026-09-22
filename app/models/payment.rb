class Payment < ApplicationRecord
  STATUSES = %w[pending paid failed expired].freeze

  belongs_to :user
  belongs_to :wallet
  has_many :payment_events, dependent: :restrict_with_error
  has_many :wahui_transactions, as: :reference, dependent: :restrict_with_error

  validates :provider, :merchant_reference, :idempotency_key, :currency, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :currency, format: { with: /\A[A-Z]{3}\z/ }
  validates :status, inclusion: { in: STATUSES }
  validates :merchant_reference, uniqueness: { scope: :provider }
  validates :idempotency_key, uniqueness: { scope: :provider }

  scope :pending, -> { where(status: "pending") }
  scope :successful, -> { where(status: "paid") }

  def pending?
    status == "pending"
  end

  def paid?
    status == "paid"
  end
end