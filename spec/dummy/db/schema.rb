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

ActiveRecord::Schema.define(version: 20160813075751) do

  create_table "http_tester_rails_projects", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "http_tester_rails_request_groups", force: :cascade do |t|
    t.integer  "testing_host_id", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "http_tester_rails_requests", force: :cascade do |t|
    t.integer  "device_type",      null: false
    t.string   "path",             null: false
    t.text     "params"
    t.integer  "http_method",      null: false
    t.integer  "request_group_id", null: false
    t.integer  "status_code",      null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "http_tester_rails_template_request_groups", force: :cascade do |t|
    t.integer  "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "http_tester_rails_template_requests", force: :cascade do |t|
    t.integer  "device_type",               null: false
    t.string   "path",                      null: false
    t.text     "params"
    t.integer  "http_method",               null: false
    t.integer  "template_request_group_id", null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "http_tester_rails_testing_hosts", force: :cascade do |t|
    t.integer  "project_id",                        null: false
    t.integer  "host_basic_auth_id",                null: false
    t.string   "name",                              null: false
    t.integer  "allowed_failure_count", default: 0, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

end