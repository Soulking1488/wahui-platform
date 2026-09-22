class PaymentProviderSetting < ApplicationRecord
  PROVIDERS = %w[doku].freeze

  encrypts :api_key
  encrypts :client_id
  encrypts :secret_key

  validates :provider, inclusion: { in: PROVIDERS }
  validates :app_environment, presence: true
  validates :api_key, :client_id, :secret_key, presence: true, if: :enabled?
  validates :provider, uniqueness: { scope: :app_environment }

  scope :current_environment, -> { where(app_environment: Rails.env) }

  def self.for_current_environment
    current_environment.find_or_initialize_by(provider: "doku") do |setting|
      setting.app_environment = Rails.env
      setting.enabled = false
    end
  end

  def doku_environment
    Rails.env.production? ? "production" : "sandbox"
  end

  def credentials
    {
      api_key:,
      client_id:,
      secret_key:,
      environment: doku_environment
    }
  end
end