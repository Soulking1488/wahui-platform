class CreateWahuiTransactions < ActiveRecord::Migration[8.1]
  def change
    create_table :wahui_transactions do |t|
      t.references :wallet, null: false, foreign_key: true
      t.decimal :amount
      t.string :transaction_type
      t.integer :reference_id

      t.timestamps
    end
  end
end
