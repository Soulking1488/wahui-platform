class CreateWahuiboards < ActiveRecord::Migration[8.1]
  def change
    create_table :wahuiboards do |t|
      t.references :board, null: false, foreign_key: true
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
