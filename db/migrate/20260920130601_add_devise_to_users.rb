class AddDeviseToUsers < ActiveRecord::Migration[8.1]
  def self.up
    change_table :users do |t|
      # Uncomment or keep only the columns your users table is missing:
      # t.string :encrypted_password, null: false, default: ""
      
      # Database authenticatable (if email/password aren't named standardly, otherwise skip)
      # Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      # Rememberable
      t.datetime :remember_created_at

      # Trackable (if you want it)
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip
    end

    add_index :users, :email, unique: true unless index_exists?(:users, :email)
    add_index :users, :reset_password_token, unique: true unless index_exists?(:users, :reset_password_token)
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
