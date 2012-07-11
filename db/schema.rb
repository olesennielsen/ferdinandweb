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

ActiveRecord::Schema.define(:version => 20120430115624) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campaigns", :force => true do |t|
    t.boolean  "published"
    t.date     "publication_date"
    t.integer  "num_of_hits"
    t.integer  "company_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "campaigns", ["company_id"], :name => "index_campaigns_on_company_id"

  create_table "campaigns_locations", :id => false, :force => true do |t|
    t.integer  "campaign_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "campaigns_locations", ["campaign_id"], :name => "index_campaigns_locations_on_campaign_id"
  add_index "campaigns_locations", ["location_id"], :name => "index_campaigns_locations_on_location_id"

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies_users", :id => false, :force => true do |t|
    t.integer  "company_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies_users", ["company_id"], :name => "index_companies_users_on_company_id"
  add_index "companies_users", ["user_id"], :name => "index_companies_users_on_user_id"

  create_table "designers", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "company_id"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "designers", ["company_id"], :name => "index_designers_on_company_id"
  add_index "designers", ["email"], :name => "index_designers_on_email", :unique => true
  add_index "designers", ["reset_password_token"], :name => "index_designers_on_reset_password_token", :unique => true

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pageobjects", :force => true do |t|
    t.integer  "x"
    t.integer  "y"
    t.integer  "object_type"
    t.integer  "color"
    t.string   "link"
    t.string   "textobject"
    t.integer  "page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pageobjects", ["page_id"], :name => "index_pageobjects_on_page_id"

  create_table "pages", :force => true do |t|
    t.integer  "number"
    t.integer  "campaign_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["campaign_id"], :name => "index_pages_on_campaign_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
