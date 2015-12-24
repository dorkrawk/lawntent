# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151224004409) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "post_collections", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "post_template_id"
  end

  create_table "post_templates", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "descriptor_field_id"
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_collection_id"
    t.integer  "post_template_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.json     "content",            default: {}, null: false
  end

  add_index "posts", ["post_collection_id"], name: "index_posts_on_post_collection_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "template_fields", force: :cascade do |t|
    t.integer  "post_template_id"
    t.string   "label"
    t.string   "field_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "template_fields", ["post_template_id"], name: "index_template_fields_on_post_template_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
