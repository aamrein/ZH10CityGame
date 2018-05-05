# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180430192202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accountings", force: :cascade do |t|
    t.bigint "group_id"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_accountings_on_group_id"
  end

  create_table "buildings", force: :cascade do |t|
    t.bigint "category_id"
    t.string "name"
    t.integer "inhabitants"
    t.integer "construction_duration_sec"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cost"
    t.integer "cost_per_hour"
    t.integer "income_per_hour"
    t.integer "required_building_id"
    t.string "image"
    t.index ["category_id"], name: "index_buildings_on_category_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
  end

  create_table "constructed_buildings", force: :cascade do |t|
    t.bigint "building_id"
    t.bigint "group_id"
    t.datetime "construction_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["building_id"], name: "index_constructed_buildings_on_building_id"
    t.index ["group_id"], name: "index_constructed_buildings_on_group_id"
  end

  create_table "event_logs", force: :cascade do |t|
    t.bigint "event_id"
    t.datetime "start"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "constructed_building_id"
    t.index ["event_id"], name: "index_event_logs_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.integer "impact_percent"
    t.integer "duration_min"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.datetime "start"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount_per_inhabitants_per_hour"
  end

  create_table "groups", force: :cascade do |t|
    t.bigint "game_id"
    t.string "name"
    t.string "email"
    t.string "phone"
    t.decimal "start_balance"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "building_ban", default: false
    t.index ["game_id"], name: "index_groups_on_game_id"
  end

  create_table "task_logs", force: :cascade do |t|
    t.bigint "task_id"
    t.bigint "group_id"
    t.datetime "start"
    t.string "comment"
    t.boolean "done"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "end"
    t.index ["group_id"], name: "index_task_logs_on_group_id"
    t.index ["task_id"], name: "index_task_logs_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "location"
    t.integer "duration_min"
    t.integer "value"
    t.boolean "settlement_immediately"
    t.string "comment"
    t.boolean "optional"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.integer "group_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "buildings", "buildings", column: "required_building_id"
  add_foreign_key "buildings", "categories"
  add_foreign_key "constructed_buildings", "buildings"
  add_foreign_key "constructed_buildings", "groups"
  add_foreign_key "event_logs", "events"
  add_foreign_key "groups", "games"
  add_foreign_key "task_logs", "tasks"
  add_foreign_key "users", "groups"
end
