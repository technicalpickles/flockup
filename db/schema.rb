# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090126213440) do

  create_table "announcements", :force => true do |t|
    t.text     "message"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flockers", :force => true do |t|
    t.string   "twitter_username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  create_table "flockers_flocks", :id => false, :force => true do |t|
    t.integer "flock_id"
    t.integer "flocker_id"
  end

  add_index "flockers_flocks", ["flock_id"], :name => "index_flockers_flocks_on_flock_id"
  add_index "flockers_flocks", ["flocker_id"], :name => "index_flockers_flocks_on_flocker_id"

  create_table "flocks", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flocks", ["name"], :name => "index_flocks_on_name"

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.string   "sluggable_type"
    t.integer  "sluggable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "slugs", ["name", "sluggable_type"], :name => "index_slugs_on_name_and_sluggable_type", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

end
