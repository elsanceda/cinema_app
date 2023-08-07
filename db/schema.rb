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

ActiveRecord::Schema[7.0].define(version: 2023_08_07_050221) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cinemas", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.integer "seats", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.text "synopsis"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "showings", force: :cascade do |t|
    t.bigint "cinema_id", null: false
    t.bigint "movie_id", null: false
    t.bigint "timeslot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cinema_id", "timeslot_id"], name: "index_showings_on_cinema_id_and_timeslot_id", unique: true
    t.index ["cinema_id"], name: "index_showings_on_cinema_id"
    t.index ["movie_id"], name: "index_showings_on_movie_id"
    t.index ["timeslot_id"], name: "index_showings_on_timeslot_id"
  end

  create_table "timeslots", force: :cascade do |t|
    t.time "time", default: "2000-01-01 02:00:00"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["time"], name: "index_timeslots_on_time", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name"
    t.string "email"
    t.string "mobile_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["mobile_number"], name: "index_users_on_mobile_number", unique: true
  end

  add_foreign_key "showings", "cinemas"
  add_foreign_key "showings", "movies"
  add_foreign_key "showings", "timeslots"
end
