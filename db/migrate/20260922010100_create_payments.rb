class CreatePayments < ActiveRecord::Migration[8.1]
  def change
    create_table :payments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :wallet, null: false, foreign_key: true
      t.string :provider, null: false
      t.string :merchant_reference, null: false
      t.string :provider_payment_id
      t.string :idempotency_key, null: false
      t.decimal :amount, precision: 12, scale: 2, null: false
      t.string :currency, limit: 3, null: false
      t.string :status, null: false, default: "pending"
      t.string :checkout_url
      t.json :metadata
      t.json :raw_response
      t.datetime :paid_at
      t.datetime :failed_at
      t.datetime :expired_at

      t.timestamps
    end

    add_index :payments, [:provider, :merchant_reference], unique: true
    add_index :payments, [:provider, :provider_payment_id], unique: true
    add_index :payments, [:provider, :idempotency_key], unique: true
    add_index :payments, :status
  end
end