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

ActiveRecord::Schema.define(version: 20160627132243) do

  create_table "likes", force: :cascade do |t|
    t.integer  "tweet_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "likes", ["tweet_id"], name: "index_likes_on_tweet_id"
  add_index "likes", ["user_id", "tweet_id"], name: "index_likes_on_unique", unique: true
  add_index "likes", ["user_id"], name: "index_likes_on_user_id"

  create_table "relationships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "following_user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "relationships", ["following_user_id"], name: "index_relationships_on_following_user_id"
  add_index "relationships", ["user_id", "following_user_id"], name: "index_following_unique", unique: true

  create_table "tweets", force: :cascade do |t|
    t.string   "body"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "likes_count",     default: 0, null: false
    t.integer  "parent_tweet_id"
    t.integer  "comments_count",  default: 0, null: false
  end

  add_index "tweets", ["parent_tweet_id"], name: "index_tweets_on_parent_tweet_id"
  add_index "tweets", ["user_id"], name: "index_tweets_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.integer  "following_count",        default: 0,  null: false
    t.integer  "followers_count",        default: 0,  null: false
    t.integer  "tweets_count",           default: 0,  null: false
    t.text     "image"
    t.text     "profile",                default: "", null: false
  end

  add_index "users", ["name"], name: "index_users_on_name", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
