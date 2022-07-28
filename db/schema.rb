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

ActiveRecord::Schema[7.0].define(version: 2022_07_28_225031) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "camp_applications", force: :cascade do |t|
    t.datetime "applied_at"
    t.datetime "completed_at"
    t.string "referral_name"
    t.integer "status", null: false
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

  create_table "camp_deposits", force: :cascade do |t|
    t.integer "status", null: false
    t.bigint "user_id"
    t.datetime "paid_at"
    t.datetime "completed_at"
    t.bigint "completed_by_id"
    t.text "private_notes"
    t.datetime "rejected_at"
    t.bigint "rejected_by_id"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "USD", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "transaction_id", null: false
    t.integer "payment_method"
    t.integer "pricing_tier"
    t.bigint "paid_by_id"
    t.datetime "refunded_at"
    t.bigint "refunded_by_id"
    t.text "notes"
    t.datetime "skipped_at"
    t.bigint "skipped_by_id"
    t.index ["user_id"], name: "index_camp_deposits_on_user_id"
  end

  create_table "camp_dues", force: :cascade do |t|
    t.integer "status", null: false
    t.bigint "user_id"
    t.datetime "paid_at"
    t.datetime "completed_at"
    t.bigint "completed_by_id"
    t.text "private_notes"
    t.datetime "rejected_at"
    t.bigint "rejected_by_id"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "USD", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "transaction_id", null: false
    t.integer "payment_method"
    t.integer "pricing_tier"
    t.bigint "paid_by_id"
    t.datetime "refunded_at"
    t.bigint "refunded_by_id"
    t.text "notes"
    t.datetime "skipped_at"
    t.bigint "skipped_by_id"
    t.index ["user_id"], name: "index_camp_dues_on_user_id"
  end

  create_table "camp_interviews", force: :cascade do |t|
    t.integer "status", null: false
    t.bigint "user_id"
    t.datetime "applied_at"
    t.datetime "completed_at"
    t.datetime "approved_at"
    t.bigint "approved_by_id"
    t.bigint "interviewed_by_id"
    t.datetime "assigned_at"
    t.text "initial_notes"
    t.text "feedback_notes"
    t.text "private_notes"
    t.datetime "rejected_at"
    t.bigint "rejected_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "completed_by_id"
    t.datetime "discarded_at"
    t.bigint "assigned_by_id"
    t.bigint "skipped_by_id"
    t.datetime "skipped_at"
    t.bigint "no_response_by_id"
    t.datetime "no_response_at"
    t.index ["discarded_at"], name: "index_camp_interviews_on_discarded_at"
    t.index ["user_id"], name: "index_camp_interviews_on_user_id"
  end

  create_table "camp_job_definitions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "status", null: false
    t.integer "timeframe", null: false
    t.text "private_notes"
    t.boolean "all_day"
    t.boolean "east_bay"
    t.boolean "strong_person"
    t.boolean "approval_required"
    t.decimal "points", precision: 4, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "notes"
    t.bigint "camp_job_description_id"
    t.datetime "begin_at"
    t.datetime "end_at"
    t.date "job_on"
    t.boolean "financial"
    t.index ["user_id"], name: "index_camp_job_definitions_on_user_id"
  end

  create_table "camp_job_descriptions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "title", null: false
    t.integer "status", null: false
    t.bigint "user_id"
    t.text "description", null: false
    t.integer "department"
  end

  create_table "camp_jobs", force: :cascade do |t|
    t.integer "status", null: false
    t.bigint "user_id", null: false
    t.datetime "assigned_at"
    t.bigint "assigned_by_id"
    t.datetime "completed_at"
    t.bigint "completed_by_id"
    t.datetime "approved_at"
    t.bigint "approved_by_id"
    t.text "private_notes"
    t.text "notes"
    t.datetime "rejected_at"
    t.bigint "rejected_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "camp_job_definition_id", null: false
    t.index ["user_id"], name: "index_camp_jobs_on_user_id"
  end

  create_table "camp_tickets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "ticket_type", null: false
    t.integer "status", null: false
    t.integer "location", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_id"
    t.integer "sale", null: false
    t.integer "availability", null: false
    t.text "private_notes"
    t.index ["user_id"], name: "index_camp_tickets_on_user_id"
  end

  create_table "camp_vehicles", force: :cascade do |t|
    t.bigint "completed_by_id"
    t.datetime "completed_at"
    t.datetime "approved_at"
    t.bigint "approved_by_id"
    t.bigint "user_id"
    t.integer "status", null: false
    t.datetime "rejected_at"
    t.bigint "rejected_by_id"
    t.integer "vehicle"
    t.string "licence_plate"
    t.text "notes"
    t.text "private_notes"
    t.boolean "sleeping"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "trailer"
    t.index ["user_id"], name: "index_camp_vehicles_on_user_id"
  end

  create_table "newsletters", force: :cascade do |t|
    t.string "email"
    t.integer "list", null: false
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
    t.integer "role", null: false
    t.integer "status", null: false
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
    t.integer "plan", null: false
    t.text "private_notes"
    t.text "tiktok_url"
    t.integer "diet"
    t.text "allergies"
    t.date "born_on"
    t.index ["discarded_at"], name: "index_users_on_discarded_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
