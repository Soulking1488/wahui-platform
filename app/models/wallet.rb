class Wallet < ApplicationRecord
	TRANSACTION_TYPES = %w[deposit withdrawal bet bet_refund payout adjustment].freeze

	belongs_to :user
	has_many :wahui_transactions, dependent: :restrict_with_error

	validates :balance, numericality: { greater_than_or_equal_to: 0 }

	def credit!(amount, transaction_type:, reference_id: nil)
		record_movement!(positive_amount(amount), transaction_type:, reference_id:)
	end

	def debit!(amount, transaction_type:, reference_id: nil)
		record_movement!(-positive_amount(amount), transaction_type:, reference_id:)
	end

	private

	def positive_amount(amount)
		value = amount.to_d
		raise ArgumentError, "amount must be greater than zero" unless value.positive?

		value
	end

	def record_movement!(delta, transaction_type:, reference_id: nil)
		unless TRANSACTION_TYPES.include?(transaction_type.to_s)
			raise ArgumentError, "invalid transaction type"
		end

		with_lock do
			balance_before = balance.to_d
			balance_after = balance_before + delta
			raise ActiveRecord::RecordInvalid, self if balance_after.negative?

			update!(balance: balance_after)
			wahui_transactions.create!(
				amount: delta,
				transaction_type: transaction_type,
				reference_id: reference_id,
				balance_before: balance_before,
				balance_after: balance_after
			)
		end
	end
end
