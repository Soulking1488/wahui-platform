class RequireBoardOnSynonyms < ActiveRecord::Migration[8.1]
  def change
    execute <<~SQL
      UPDATE synonyms
      INNER JOIN wahuiboards ON wahuiboards.id = synonyms.wahuiboard_id
      SET synonyms.board_id = wahuiboards.board_id
      WHERE synonyms.board_id IS NULL
    SQL

    change_column_null :synonyms, :board_id, false
  end
end
