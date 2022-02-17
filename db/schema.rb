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

ActiveRecord::Schema[7.0].define(version: 2022_02_17_054056) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "camp_applications", force: :cascade do |t|
    t.datetime "applied_at"
    t.datetime "completed_at"
    t.string "referral_name"
    t.integer "status", default: 0, null: false
    t.text "what_excites_you"
    t.text "who_are_you"
    t.text "plan_to_contribute"
    t.integer "vaccine_status"
    t.text "food_allergies"
    t.date "arrival_on"
    t.date "departure_on"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "covid_protocol"
    t.integer "burning_man_year_count"
    t.datetime "approved_at"
    t.bigint "approved_by_id"
    t.datetime "rejected_at"
    t.bigint "completed_by_id"
    t.bigint "rejected_by_id"
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_camp_applications_on_discarded_at"
    t.index ["user_id"], name: "index_camp_applications_on_user_id"
  end

  create_table "camp_interviews", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.bigint "user_id"
    t.datetime "applied_at"
    t.datetime "completed_at"
    t.datetime "approved_at"
    t.bigint "approved_by_id"
    t.bigint "interviewed_by_id"
    t.datetime "assigned_at"
    t.bigint "skipped_at"
    t.text "initial_notes"
    t.text "feedback_notes"
    t.text "private_notes"
    t.datetime "rejected_at"
    t.bigint "rejected_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "completed_by_id"
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_camp_interviews_on_discarded_at"
    t.index ["user_id"], name: "index_camp_interviews_on_user_id"
  end

  create_table "newsletters", force: :cascade do |t|
    t.string "email"
    t.integer "list", default: 0, null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "unsubscribe_token", null: false
    t.datetime "unsubscribed_at"
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_newsletters_on_discarded_at"
    t.index ["email"], name: "index_newsletters_on_email", unique: true
    t.index ["unsubscribe_token"], name: "index_newsletters_on_unsubscribe_token", unique: true
    t.index ["user_id"], name: "index_newsletters_on_user_id", unique: true
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
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "title"
    t.jsonb "previous_years", default: []
    t.string "country_code"
    t.string "postal_code"
    t.text "facebook_url"
    t.text "instagram_url"
    t.text "twitter_url"
    t.integer "pronouns"
    t.datetime "discarded_at"
    t.integer "plan", default: 0, null: false
    t.index ["discarded_at"], name: "index_users_on_discarded_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
