class AddPolymorphicReferenceToWahuiTransactions < ActiveRecord::Migration[8.1]
  def change
    add_column :wahui_transactions, :reference_type, :string
    change_column :wahui_transactions, :reference_id, :bigint
    add_index :wahui_transactions, [:reference_type, :reference_id]
  end
end