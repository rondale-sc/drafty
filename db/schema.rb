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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110819181749) do

  create_table "drafts", :force => true do |t|
    t.integer  "team_id"
    t.integer  "player_id"
    t.datetime "draft_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "position"
    t.string   "team"
    t.integer  "rank",         :limit => 255
    t.boolean  "selected"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "team_id"
    t.integer  "draft_id"
    t.string   "nfl_team"
    t.float    "average_pick"
    t.integer  "minimum_pick"
    t.integer  "maximum_pick"
    t.string   "url"
    t.integer  "bye_week"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "player_name"
    t.integer  "draft_order"
  end

end
