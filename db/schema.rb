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

ActiveRecord::Schema[8.1].define(version: 2026_09_22_010400) do
  create_table "bets", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.decimal "amount", precision: 12, scale: 2, null: false
    t.bigint "board_id", null: false
    t.datetime "cancelled_at"
    t.datetime "created_at", null: false
    t.datetime "placed_at", null: false
    t.string "status", default: "placed", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "wahuiboard_id", null: false
    t.index ["board_id"], name: "index_bets_on_board_id"
    t.index ["status"], name: "index_bets_on_status"
    t.index ["user_id"], name: "index_bets_on_user_id"
    t.index ["wahuiboard_id", "board_id"], name: "index_bets_on_wahuiboard_id_and_board_id"
    t.index ["wahuiboard_id"], name: "index_bets_on_wahuiboard_id"
  end

  create_table "boards", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.boolean "active"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "payment_events", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "event_type"
    t.text "payload", size: :long, null: false, collation: "utf8mb4_bin"
    t.bigint "payment_id", null: false
    t.string "provider", null: false
    t.string "provider_event_id", null: false
    t.datetime "updated_at", null: false
    t.index ["payment_id"], name: "index_payment_events_on_payment_id"
    t.index ["provider", "provider_event_id"], name: "index_payment_events_on_provider_and_provider_event_id", unique: true
    t.check_constraint "json_valid(`payload`)", name: "payload"
  end

  create_table "payment_provider_settings", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.text "api_key"
    t.string "app_environment", null: false
    t.text "client_id"
    t.datetime "created_at", null: false
    t.boolean "enabled", default: false, null: false
    t.datetime "last_tested_at"
    t.string "provider", null: false
    t.text "secret_key"
    t.datetime "updated_at", null: false
    t.index ["provider", "app_environment"], name: "idx_on_provider_app_environment_7c8d76e778", unique: true
  end

  create_table "payments", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.decimal "amount", precision: 12, scale: 2, null: false
    t.string "checkout_url"
    t.datetime "created_at", null: false
    t.string "currency", limit: 3, null: false
    t.datetime "expired_at"
    t.datetime "failed_at"
    t.string "idempotency_key", null: false
    t.string "merchant_reference", null: false
    t.text "metadata", size: :long, collation: "utf8mb4_bin"
    t.datetime "paid_at"
    t.string "provider", null: false
    t.string "provider_payment_id"
    t.text "raw_response", size: :long, collation: "utf8mb4_bin"
    t.string "status", default: "pending", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "wallet_id", null: false
    t.index ["provider", "idempotency_key"], name: "index_payments_on_provider_and_idempotency_key", unique: true
    t.index ["provider", "merchant_reference"], name: "index_payments_on_provider_and_merchant_reference", unique: true
    t.index ["provider", "provider_payment_id"], name: "index_payments_on_provider_and_provider_payment_id", unique: true
    t.index ["status"], name: "index_payments_on_status"
    t.index ["user_id"], name: "index_payments_on_user_id"
    t.index ["wallet_id"], name: "index_payments_on_wallet_id"
    t.check_constraint "json_valid(`metadata`)", name: "metadata"
    t.check_constraint "json_valid(`raw_response`)", name: "raw_response"
  end

  create_table "synonyms", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "board_id", null: false
    t.datetime "created_at", null: false
    t.string "mapping"
    t.datetime "updated_at", null: false
    t.bigint "wahuiboard_id"
    t.string "word"
    t.index ["board_id", "word"], name: "index_synonyms_on_board_id_and_word", unique: true
    t.index ["board_id"], name: "index_synonyms_on_board_id"
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
    t.decimal "amount", precision: 12, scale: 2, null: false
    t.decimal "balance_after", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "balance_before", precision: 12, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.bigint "reference_id"
    t.string "reference_type"
    t.string "transaction_type", null: false
    t.datetime "updated_at", null: false
    t.bigint "wallet_id", null: false
    t.index ["reference_type", "reference_id"], name: "index_wahui_transactions_on_reference_type_and_reference_id"
    t.index ["transaction_type"], name: "index_wahui_transactions_on_transaction_type"
    t.index ["wallet_id"], name: "index_wahui_transactions_on_wallet_id"
  end

  create_table "wahuiboards", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.datetime "announced_at"
    t.datetime "announcement_time"
    t.datetime "betting_closing_time"
    t.bigint "board_id", null: false
    t.text "cancellation_reason"
    t.datetime "cancelled_at"
    t.datetime "closed_at"
    t.text "clue_1"
    t.text "clue_2"
    t.text "clue_3"
    t.text "clue_4"
    t.datetime "created_at", null: false
    t.text "description"
    t.decimal "house_bet_amount", precision: 12, scale: 2
    t.bigint "house_bet_board_id"
    t.datetime "opens_at"
    t.integer "public_number", null: false
    t.datetime "published_at"
    t.datetime "settled_at"
    t.string "status", default: "draft", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_wahuiboards_on_board_id"
    t.index ["house_bet_board_id"], name: "index_wahuiboards_on_house_bet_board_id"
    t.index ["public_number"], name: "index_wahuiboards_on_public_number", unique: true
    t.index ["status"], name: "index_wahuiboards_on_status"
  end

  create_table "wallets", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.decimal "balance", precision: 12, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_wallets_on_user_id", unique: true
  end

  add_foreign_key "bets", "boards"
  add_foreign_key "bets", "users"
  add_foreign_key "bets", "wahuiboards"
  add_foreign_key "payment_events", "payments"
  add_foreign_key "payments", "users"
  add_foreign_key "payments", "wallets"
  add_foreign_key "synonyms", "boards"
  add_foreign_key "synonyms", "wahuiboards"
  add_foreign_key "wahui_transactions", "wallets"
  add_foreign_key "wahuiboards", "boards"
  add_foreign_key "wahuiboards", "boards", column: "house_bet_board_id"
  add_foreign_key "wallets", "users"
end
