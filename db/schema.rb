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

ActiveRecord::Schema[8.0].define(version: 2023_03_23_230108) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.bigint "patient_id", null: false
    t.date "date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "time"
    t.string "patientname"
    t.index ["doctor_id"], name: "index_appointments_on_doctor_id"
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "branch_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "country_id", null: false
    t.index ["country_id"], name: "index_cities_on_country_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "doctor_id"
    t.bigint "patient_id"
    t.string "comment"
    t.float "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_comments_on_doctor_id"
    t.index ["patient_id"], name: "index_comments_on_patient_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "branch_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.string "dept_manager_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doctor_locations", force: :cascade do |t|
    t.bigint "doctor_id"
    t.bigint "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_doctor_locations_on_doctor_id"
    t.index ["location_id"], name: "index_doctor_locations_on_location_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "education"
    t.string "speciality"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "password_digest"
    t.string "image"
    t.boolean "isaccept_newpatients"
    t.boolean "video_vistits"
    t.boolean "doctor"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "section"
    t.string "role"
    t.integer "department_id"
    t.integer "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "address_line_one"
    t.string "address_line_two"
    t.string "city"
    t.integer "zipcode"
    t.bigint "contact_number"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
  end

  create_table "patients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.bigint "contact_number"
    t.string "clinic_location"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "password_digest"
    t.boolean "patient"
  end

  create_table "project_employees", force: :cascade do |t|
    t.integer "employee_id"
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "client_name"
    t.string "sector"
    t.integer "start_date"
    t.integer "end_date"
    t.integer "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.string "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "username"
  end

  add_foreign_key "appointments", "doctors"
  add_foreign_key "appointments", "patients"
  add_foreign_key "cities", "countries"
end
