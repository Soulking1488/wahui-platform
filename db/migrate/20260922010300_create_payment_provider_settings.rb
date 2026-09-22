class CreatePaymentProviderSettings < ActiveRecord::Migration[8.1]
  def change
    create_table :payment_provider_settings do |t|
      t.string :provider, null: false
      t.string :app_environment, null: false
      t.text :api_key
      t.text :client_id
      t.text :secret_key
      t.boolean :enabled, null: false, default: false
      t.datetime :last_tested_at

      t.timestamps
    end

    add_index :payment_provider_settings, [:provider, :app_environment], unique: true
  end
end