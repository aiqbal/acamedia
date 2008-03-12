# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 7) do

  create_table "course_users", :force => true do |t|
    t.integer  "course_id",  :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", :force => true do |t|
    t.string   "name",        :default => "", :null => false
    t.text     "description", :default => "", :null => false
    t.integer  "created_by",                  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "disciplines", :force => true do |t|
    t.string   "name",        :default => "", :null => false
    t.text     "description", :default => "", :null => false
    t.integer  "created_by",                  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "disciplines_users", :id => false, :force => true do |t|
    t.integer  "user_id",       :null => false
    t.integer  "discipline_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "school_users", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "school_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", :force => true do |t|
    t.string   "name",        :default => "", :null => false
    t.text     "description", :default => "", :null => false
    t.integer  "created_by",                  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",           :limit => 80, :default => "", :null => false
    t.string   "salted_password", :limit => 40, :default => "", :null => false
    t.string   "firstname",       :limit => 40
    t.string   "lastname",        :limit => 40
    t.string   "salt",            :limit => 40, :default => "", :null => false
    t.integer  "verified",                      :default => 0
    t.string   "role",            :limit => 40
    t.string   "security_token",  :limit => 40
    t.datetime "token_expiry"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "logged_in_at"
    t.integer  "deleted",                       :default => 0
    t.datetime "delete_after"
  end

  create_table "users_disciplines", :id => false, :force => true do |t|
    t.integer  "user_id",       :null => false
    t.integer  "discipline_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
