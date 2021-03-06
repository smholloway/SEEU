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

ActiveRecord::Schema.define(:version => 20110210001015) do

  create_table "actuators", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "manufacturer"
    t.string   "model"
    t.string   "data_uri"
    t.string   "configuration_uri"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "valid_values"
  end

  create_table "commands", :force => true do |t|
    t.string   "data"
    t.integer  "actuator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "manufacturers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "models", :force => true do |t|
    t.string   "name"
    t.integer  "manufacturer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "readings", :force => true do |t|
    t.string   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sensor_id"
  end

  create_table "rules", :force => true do |t|
    t.text     "rule"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sensors", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "manufacturer"
    t.string   "model"
    t.string   "data_uri"
    t.string   "configuration_uri"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "valid_values"
  end

end
