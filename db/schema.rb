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

ActiveRecord::Schema.define(:version => 20130228034453) do

  create_table "logs", :force => true do |t|
    t.string   "name"
    t.float    "weight"
    t.integer  "sets"
    t.integer  "reps"
    t.string   "notes"
    t.datetime "date"
    t.integer  "specific_workout_id"
    t.string   "specific_workout_type"
    t.integer  "workout_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "units"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "w531s", :force => true do |t|
    t.integer  "cycle"
    t.integer  "expected_reps"
    t.integer  "week"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "workouts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "workout_id", :limit => 255
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.string   "type",                      :default => "5/3/1"
  end

end
