class AllowEmptyPaymentProviderCredentials < ActiveRecord::Migration[8.1]
  def change
    change_column_null :payment_provider_settings, :api_key, true
    change_column_null :payment_provider_settings, :client_id, true
    change_column_null :payment_provider_settings, :secret_key, true
  end
end