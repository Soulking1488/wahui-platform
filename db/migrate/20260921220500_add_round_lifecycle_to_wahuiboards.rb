class AddRoundLifecycleToWahuiboards < ActiveRecord::Migration[8.1]
  def change
    change_table :wahuiboards do |t|
      t.integer :public_number
      t.string :status, null: false, default: "draft"
      t.datetime :opens_at
      t.datetime :published_at
      t.datetime :closed_at
      t.datetime :announced_at
      t.datetime :settled_at
      t.datetime :cancelled_at
      t.text :cancellation_reason
    end

    reversible do |direction|
      direction.up do
        execute <<~SQL
          UPDATE wahuiboards
          SET public_number = id,
              opens_at = created_at,
              status = 'draft'
          WHERE public_number IS NULL
        SQL
      end
    end

    change_column_null :wahuiboards, :public_number, false
    add_index :wahuiboards, :public_number, unique: true
    add_index :wahuiboards, :status
  end
end
