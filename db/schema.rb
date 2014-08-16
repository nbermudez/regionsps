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

ActiveRecord::Schema.define(:version => 20140621101333) do

  create_table "articles", :force => true do |t|
    t.boolean  "active"
    t.boolean  "published"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "position"
  end

  create_table "chapels", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.integer  "stake_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "chapels", ["stake_id"], :name => "index_chapels_on_stake_id"

  create_table "chapelusers", :force => true do |t|
    t.integer  "chapel_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "chapelusers", ["chapel_id"], :name => "index_chapelusers_on_chapel_id"
  add_index "chapelusers", ["user_id"], :name => "index_chapelusers_on_user_id"

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.string   "place"
    t.datetime "celebrated_at"
    t.boolean  "is_public"
    t.text     "description"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "invited_group"
  end

  create_table "goals", :force => true do |t|
    t.integer  "total"
    t.integer  "typestadistic_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "user_id"
    t.integer  "chapel_id"
    t.integer  "year"
    t.boolean  "sentToStake"
    t.boolean  "ableEditing"
  end

  add_index "goals", ["chapel_id"], :name => "index_goals_on_chapel_id"
  add_index "goals", ["typestadistic_id"], :name => "index_goals_on_typestadistic_id"
  add_index "goals", ["user_id"], :name => "index_goals_on_user_id"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "invitations", :id => false, :force => true do |t|
    t.integer  "event_id"
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "permissions", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "permissions_roles", :id => false, :force => true do |t|
    t.integer "permission_id"
    t.integer "role_id"
  end

  create_table "region_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "region_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "region_users", ["region_id"], :name => "index_region_users_on_region_id"
  add_index "region_users", ["user_id"], :name => "index_region_users_on_user_id"

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "resources", :force => true do |t|
    t.string   "filename"
    t.string   "content_type"
    t.string   "file"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "thumbnail"
    t.text     "description"
    t.string   "url"
    t.integer  "position"
    t.integer  "article_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "description"
    t.integer  "user_id"
  end

  create_table "stadistics", :force => true do |t|
    t.integer  "month"
    t.integer  "year"
    t.integer  "total"
    t.integer  "typestadistic_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "user_id"
    t.integer  "chapel_id"
  end

  add_index "stadistics", ["chapel_id"], :name => "index_stadistics_on_chapel_id"
  add_index "stadistics", ["typestadistic_id"], :name => "index_stadistics_on_typestadistic_id"
  add_index "stadistics", ["user_id"], :name => "index_stadistics_on_user_id"

  create_table "stakes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "region_id"
  end

  add_index "stakes", ["region_id"], :name => "index_stakes_on_region_id"

  create_table "stakeusers", :force => true do |t|
    t.integer  "stake_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "stakeusers", ["stake_id"], :name => "index_stakeusers_on_stake_id"
  add_index "stakeusers", ["user_id"], :name => "index_stakeusers_on_user_id"

  create_table "stories", :force => true do |t|
    t.string   "report"
    t.integer  "year"
    t.string   "stake"
    t.text     "abstract"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "url"
  end

  create_table "tag_categorizations", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "category_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "tag_position"
  end

  create_table "taggings", :id => false, :force => true do |t|
    t.integer  "resource_id"
    t.integer  "tag_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "title"
    t.integer  "resource_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "tags", ["resource_id"], :name => "index_tags_on_resource_id"

  create_table "tags_category", :id => false, :force => true do |t|
    t.integer "tag_id"
    t.integer "category_id"
  end

  create_table "typestadistics", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "encrypted_password"
    t.string   "salt"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "phone"
    t.integer  "chapel_id"
    t.string   "password_reset_code", :limit => 40
  end

  add_index "users", ["chapel_id"], :name => "index_users_on_chapel_id"

  create_table "users_groups", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "group_id"
  end

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

end
