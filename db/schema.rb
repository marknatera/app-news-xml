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

ActiveRecord::Schema.define(version: 20160517203111) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "news_xmls", force: :cascade do |t|
    t.string   "forum"
    t.string   "forum_title"
    t.string   "discussion_title"
    t.string   "language"
    t.string   "topic_url"
    t.text     "topic_text"
    t.string   "spam_score"
    t.string   "post_num"
    t.string   "post_id"
    t.string   "post_url"
    t.date     "post_date"
    t.time     "post_time"
    t.string   "username"
    t.text     "post"
    t.string   "country"
    t.string   "main_image"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

end
