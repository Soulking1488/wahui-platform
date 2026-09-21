class CreateBets < ActiveRecord::Migration[8.1]
  def change
    create_table :bets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :wahuiboard, null: false, foreign_key: true
      t.references :board, null: false, foreign_key: true
      t.decimal :amount, precision: 12, scale: 2, null: false
      t.string :status, null: false, default: "placed"
      t.datetime :placed_at, null: false
      t.datetime :cancelled_at

      t.timestamps
    end

    add_index :bets, :status
    add_index :bets, [:wahuiboard_id, :board_id]
  end
end
