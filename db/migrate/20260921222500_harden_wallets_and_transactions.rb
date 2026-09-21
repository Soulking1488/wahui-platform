class HardenWalletsAndTransactions < ActiveRecord::Migration[8.1]
  def change
    change_table :wallets do |t|
      t.change :user_id, :bigint, null: false
      t.change :balance, :decimal, precision: 12, scale: 2, null: false, default: 0
    end

    add_index :wallets, :user_id, unique: true
    add_foreign_key :wallets, :users

    change_table :wahui_transactions do |t|
      t.change :amount, :decimal, precision: 12, scale: 2, null: false
      t.change :transaction_type, :string, null: false
      t.decimal :balance_before, precision: 12, scale: 2, null: false, default: 0
      t.decimal :balance_after, precision: 12, scale: 2, null: false, default: 0
    end

    add_index :wahui_transactions, :transaction_type
  end
end
