class WahuiTransaction < ApplicationRecord
  belongs_to :wallet

  validates :amount, numericality: { other_than: 0 }
  validates :transaction_type, inclusion: { in: Wallet::TRANSACTION_TYPES }
  validates :balance_before, :balance_after, numericality: true
end
