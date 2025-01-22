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

ActiveRecord::Schema[7.1].define(version: 2024_12_03_120821) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

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

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "financial_reports", force: :cascade do |t|
    t.bigint "subdomain_id", null: false
    t.integer "data_type", default: 0, null: false
    t.decimal "amount", precision: 10, scale: 2
    t.text "description"
    t.bigint "uploaded_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subdomain_id"], name: "index_financial_reports_on_subdomain_id"
    t.index ["uploaded_by_id"], name: "index_financial_reports_on_uploaded_by_id"
  end

  create_table "investigations", force: :cascade do |t|
    t.bigint "subdomain_id", null: false
    t.bigint "iidm_admin_id"
    t.text "description"
    t.text "findings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "financial_report_id"
    t.index ["financial_report_id"], name: "index_investigations_on_financial_report_id"
    t.index ["iidm_admin_id"], name: "index_investigations_on_iidm_admin_id"
    t.index ["subdomain_id"], name: "index_investigations_on_subdomain_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "subdomain_id", null: false
    t.bigint "public_user_id"
    t.text "content"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "investigation_id"
    t.bigint "financial_report_id"
    t.index ["financial_report_id"], name: "index_reviews_on_financial_report_id"
    t.index ["investigation_id"], name: "index_reviews_on_investigation_id"
    t.index ["public_user_id"], name: "index_reviews_on_public_user_id"
    t.index ["subdomain_id"], name: "index_reviews_on_subdomain_id"
  end

  create_table "subdomains", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "role"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_subdomains", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "subdomain_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subdomain_id"], name: "index_users_subdomains_on_subdomain_id"
    t.index ["user_id"], name: "index_users_subdomains_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "financial_reports", "subdomains"
  add_foreign_key "financial_reports", "users", column: "uploaded_by_id"
  add_foreign_key "investigations", "financial_reports"
  add_foreign_key "investigations", "subdomains"
  add_foreign_key "investigations", "users", column: "iidm_admin_id"
  add_foreign_key "reviews", "financial_reports"
  add_foreign_key "reviews", "investigations"
  add_foreign_key "reviews", "subdomains"
  add_foreign_key "reviews", "users", column: "public_user_id"
  add_foreign_key "users_subdomains", "subdomains"
  add_foreign_key "users_subdomains", "users"
end
