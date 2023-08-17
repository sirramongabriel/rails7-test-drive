# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_15_142543) do
  create_table "addresses", force: :cascade do |t|
    t.string "street_address", null: false
    t.string "city", null: false
    t.float "lat"
    t.float "long"
    t.string "state", null: false
    t.string "zip_code", null: false
    t.string "addressable_id", null: false
    t.string "addressable_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_id", "addressable_type"], name: "index_addresses_by_id_and_type"
  end

  create_table "drivers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rides", force: :cascade do |t|
    t.integer "score"
    t.integer "earnings"
    t.string "duration_in_hours"
    t.string "distance_in_miles"
    t.string "commute_duration_in_hours"
    t.string "commute_distance_in_miles"
    t.string "driving_duration_in_hours"
    t.string "driving_distance_in_miles"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["score"], name: "index_rides_by_score"
  end

end
