class CreatePaymentEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :payment_events do |t|
      t.references :payment, null: false, foreign_key: true
      t.string :provider, null: false
      t.string :provider_event_id, null: false
      t.string :event_type
      t.json :payload, null: false

      t.timestamps
    end

    add_index :payment_events, [:provider, :provider_event_id], unique: true
  end
end