class AddBoardToSynonyms < ActiveRecord::Migration[8.1]
  def change
    add_reference :synonyms, :board, foreign_key: true
    add_index :synonyms, [:board_id, :word], unique: true
  end
end
