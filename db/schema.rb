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

ActiveRecord::Schema.define(version: 20150516025807) do

  create_table "courses", force: :cascade do |t|
    t.integer  "courseID"
    t.integer  "enroll"
    t.integer  "max_enroll"
    t.string   "term"
    t.string   "state"
    t.text     "note"
    t.string   "timetable"
    t.string   "division_state", default: "spending"
    t.string   "user_rejected"
    t.string   "user_confirm"
    t.integer  "user_id"
    t.integer  "subject_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "courses", ["subject_id"], name: "index_courses_on_subject_id"
  add_index "courses", ["user_id"], name: "index_courses_on_user_id"

  create_table "subject_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subject_users", ["subject_id"], name: "index_subject_users_on_subject_id"
  add_index "subject_users", ["user_id"], name: "index_subject_users_on_user_id"

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.integer  "tc"
    t.integer  "lt",         default: 0
    t.integer  "bt",         default: 0
    t.string   "subjectID"
    t.string   "species",    default: "normal"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "subjects", ["subjectID"], name: "index_subjects_on_subjectID"

  create_table "timetables", force: :cascade do |t|
    t.string   "day"
    t.string   "start_time"
    t.string   "finish_time"
    t.string   "room"
    t.integer  "course_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "timetables", ["course_id"], name: "index_timetables_on_course_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "avatar"
    t.string   "role",                   default: "normal"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
