class Synonym < ApplicationRecord
	belongs_to :board
	belongs_to :wahuiboard, optional: true

	validates :word, presence: true, uniqueness: { scope: :board_id }
end
