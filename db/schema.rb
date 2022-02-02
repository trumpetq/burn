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

ActiveRecord::Schema.define(version: 2022_02_02_035005) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "steps", force: :cascade do |t|
    t.string "name", null: false
    t.string "title", null: false
    t.text "description"
    t.integer "status", default: 0, null: false
    t.datetime "available_at", precision: 6
    t.datetime "closed_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_steps", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "step_id"
    t.integer "status", default: 0, null: false
    t.datetime "completed_at"
    t.string "stepable_type"
    t.bigint "stepable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["step_id"], name: "index_user_steps_on_step_id"
    t.index ["stepable_type", "stepable_id"], name: "index_user_steps_on_stepable"
    t.index ["user_id"], name: "index_user_steps_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "phone_number"
    t.string "name", null: false
    t.string "playa_name"
    t.integer "role", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.string "time_zone", default: "Pacific Time (US & Canada)", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "remember_created_at", precision: 6
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: 6
    t.datetime "last_sign_in_at", precision: 6
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description"
    t.string "title"
    t.jsonb "previous_years", default: [], null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
