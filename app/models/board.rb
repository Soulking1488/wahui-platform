class Board < ApplicationRecord
	has_many :synonyms, dependent: :destroy
	has_many :bets, dependent: :restrict_with_error
end
