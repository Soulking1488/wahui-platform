class User < ApplicationRecord
  has_many :bets, dependent: :restrict_with_error
  has_one :wallet, dependent: :restrict_with_error
  has_many :payments, dependent: :restrict_with_error

  after_create :create_player_wallet, if: :player?

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, presence: true, inclusion: { in: %w[player house_operator risk_manager admin] }

  def admin?
    role == "admin"
  end

  def house_operator?
    role == "house_operator" || admin?
  end

  def risk_manager?
    role == "risk_manager" || admin?
  end

  def player?
    role == "player"
  end

  def can_manage_boards?
    admin? || house_operator?
  end

  def can_review_transactions?
    admin? || risk_manager?
  end

  private

  def create_player_wallet
    create_wallet!(balance: 0)
  end
end
