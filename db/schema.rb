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

ActiveRecord::Schema.define(:version => 201301071035051) do

  create_table "addresses", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "babies", :force => true do |t|
    t.string   "first_name", :null => false
    t.string   "last_name",  :null => false
    t.date     "birthday"
    t.integer  "gender"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "gifts", :force => true do |t|
    t.integer  "shipping_address_id"
    t.integer  "billing_address_id"
    t.string   "recipient_email",                      :null => false
    t.string   "sender_email",                         :null => false
    t.text     "note"
    t.integer  "plan_type"
    t.integer  "baby_id"
    t.datetime "redeem_date"
    t.string   "redeem_status"
    t.float    "price",               :default => 0.0
    t.float    "tax",                 :default => 0.0
    t.float    "shipping_fee",        :default => 0.0
    t.float    "total"
    t.string   "transaction_code"
    t.datetime "transaction_date"
    t.string   "transaction_status"
    t.string   "gift_code"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "baby_id",                              :null => false
    t.integer  "plan_type",                            :null => false
    t.float    "price",               :default => 0.0
    t.float    "tax",                 :default => 0.0
    t.float    "shipping_fee",        :default => 0.0
    t.float    "total"
    t.string   "current_step"
    t.integer  "shipping_address_id"
    t.integer  "billing_address_id"
    t.integer  "purchaser_id"
    t.string   "transaction_code"
    t.date     "transaction_date"
    t.string   "transaction_status"
    t.string   "gift_code"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

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
    t.integer  "shipping_id"
    t.integer  "billing_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
