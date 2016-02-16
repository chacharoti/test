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

ActiveRecord::Schema.define(version: 20160216152525) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "from_user_id"
    t.integer  "to_user_id"
    t.string   "type"
    t.integer  "seen",          default: 0,         null: false
    t.integer  "read",          default: 0,         null: false
    t.string   "message"
    t.integer  "connection_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "status",        default: "waiting", null: false
  end

  add_index "activities", ["from_user_id", "to_user_id"], name: "index_activities_on_from_user_id_and_to_user_id", using: :btree

  create_table "app_settings", force: :cascade do |t|
    t.string   "key"
    t.string   "value"
    t.integer  "is_public",  default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "comment_post_users", force: :cascade do |t|
    t.string   "message"
    t.integer  "post_id"
    t.integer  "user_id"
    t.integer  "user_likes_count", default: 0, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "location_id"
  end

  add_index "comment_post_users", ["post_id"], name: "index_comment_post_users_on_post_id", using: :btree

  create_table "conversation_users", force: :cascade do |t|
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.string   "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "conversation_users", ["conversation_id", "user_id"], name: "index_conversation_users_on_conversation_id_and_user_id", using: :btree

  create_table "conversations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devices", force: :cascade do |t|
    t.string   "push_notification_token"
    t.string   "type"
    t.string   "string"
    t.integer  "user_id"
    t.string   "identifier"
    t.string   "model"
    t.string   "os_version"
    t.string   "app_version"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "devices", ["user_id"], name: "index_devices_on_user_id", using: :btree

  create_table "emotion_post_users", force: :cascade do |t|
    t.integer  "emotion_type_id"
    t.integer  "post_id"
    t.integer  "user_id"
    t.integer  "user_likes_count", default: 0, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "location_id"
  end

  add_index "emotion_post_users", ["post_id"], name: "index_emotion_post_users_on_post_id", using: :btree

  create_table "emotion_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "media", force: :cascade do |t|
    t.string   "owner_type"
    t.integer  "owner_id"
    t.string   "file_key"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "meta_data"
  end

  add_index "media", ["owner_type", "owner_id"], name: "media_indexes", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.datetime "editted_at"
    t.datetime "deleted_at"
    t.string   "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "packets", force: :cascade do |t|
    t.string   "name"
    t.integer  "version"
    t.string   "link"
    t.integer  "is_public",  default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "post_user_follows", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "location_id"
  end

  add_index "post_user_follows", ["post_id"], name: "index_post_user_follows_on_post_id", using: :btree

  create_table "post_user_seens", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "post_user_seens", ["post_id"], name: "index_post_user_seens_on_post_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "message"
    t.integer  "emotions_count",   default: 0, null: false
    t.integer  "comments_count",   default: 0, null: false
    t.integer  "followers_count",  default: 0, null: false
    t.integer  "seen_users_count", default: 0, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "location_id"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "texts", force: :cascade do |t|
    t.text     "raw"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "owner_type"
    t.integer  "owner_id"
  end

  add_index "texts", ["owner_type", "owner_id"], name: "index_texts_on_owner_type_and_owner_id", using: :btree

  create_table "user_locations", force: :cascade do |t|
    t.integer  "user_id"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "nickname"
    t.date     "birthday"
    t.integer  "gender"
    t.string   "phone_number"
    t.string   "fb_user_id"
    t.string   "fb_access_token"
    t.integer  "current_location_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
