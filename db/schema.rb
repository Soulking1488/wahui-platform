# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_09_21_210000) do
  create_table "boards", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.boolean "active"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "synonyms", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "mapping"
    t.datetime "updated_at", null: false
    t.bigint "wahuiboard_id"
    t.string "word"
    t.index ["wahuiboard_id"], name: "index_synonyms_on_wahuiboard_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.string "password_digest"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "role", default: "player", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wahui_transactions", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.decimal "amount", precision: 10
    t.datetime "created_at", null: false
    t.integer "reference_id"
    t.string "transaction_type"
    t.datetime "updated_at", null: false
    t.bigint "wallet_id", null: false
    t.index ["wallet_id"], name: "index_wahui_transactions_on_wallet_id"
  end

  create_table "wahuiboards", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.datetime "announcement_time"
    t.datetime "betting_closing_time"
    t.bigint "board_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.decimal "house_bet_amount", precision: 12, scale: 2
    t.bigint "house_bet_board_id"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_wahuiboards_on_board_id"
    t.index ["house_bet_board_id"], name: "index_wahuiboards_on_house_bet_board_id"
  end

  create_table "wallets", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.decimal "balance", precision: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  add_foreign_key "synonyms", "wahuiboards"
  add_foreign_key "wahui_transactions", "wallets"
  add_foreign_key "wahuiboards", "boards"
  add_foreign_key "wahuiboards", "boards", column: "house_bet_board_id"
end
