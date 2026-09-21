class CreateSynonyms < ActiveRecord::Migration[8.1]
  def change
    create_table :synonyms do |t|
      t.string :word
      t.string :mapping

      t.timestamps
    end
  end
end
