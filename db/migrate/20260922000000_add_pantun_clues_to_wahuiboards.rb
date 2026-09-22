class AddPantunCluesToWahuiboards < ActiveRecord::Migration[8.1]
  def change
    add_column :wahuiboards, :clue_1, :text
    add_column :wahuiboards, :clue_2, :text
    add_column :wahuiboards, :clue_3, :text
    add_column :wahuiboards, :clue_4, :text
  end
end
