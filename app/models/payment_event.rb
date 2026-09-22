class PaymentEvent < ApplicationRecord
  belongs_to :payment

  validates :provider, :provider_event_id, presence: true
  validates :provider_event_id, uniqueness: { scope: :provider }
end