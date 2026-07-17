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

ActiveRecord::Schema[7.2].define(version: 2026_07_17_124138) do
  create_table "class_sessions", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "semester_id", null: false
    t.integer "teacher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id", "semester_id", "teacher_id"], name: "index_class_sessions_on_course_semester_teacher", unique: true
    t.index ["course_id"], name: "index_class_sessions_on_course_id"
    t.index ["semester_id"], name: "index_class_sessions_on_semester_id"
    t.index ["teacher_id"], name: "index_class_sessions_on_teacher_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.integer "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_courses_on_code", unique: true
    t.index ["department_id"], name: "index_courses_on_department_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_departments_on_name", unique: true
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer "class_session_id", null: false
    t.integer "student_id", null: false
    t.string "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["class_session_id", "student_id"], name: "index_enrollments_on_class_session_and_student", unique: true
    t.index ["class_session_id"], name: "index_enrollments_on_class_session_id"
    t.index ["student_id"], name: "index_enrollments_on_student_id"
  end

  create_table "semesters", force: :cascade do |t|
    t.string "name", null: false
    t.string "season", null: false
    t.integer "year", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_semesters_on_name", unique: true
    t.index ["season", "year"], name: "index_semesters_on_season_and_year", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "role", null: false
    t.integer "grade"
    t.integer "advisor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["advisor_id"], name: "index_users_on_advisor_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["role"], name: "index_users_on_role"
  end

  add_foreign_key "class_sessions", "courses"
  add_foreign_key "class_sessions", "semesters"
  add_foreign_key "class_sessions", "users", column: "teacher_id"
  add_foreign_key "courses", "departments"
  add_foreign_key "enrollments", "class_sessions"
  add_foreign_key "enrollments", "users", column: "student_id"
  add_foreign_key "users", "users", column: "advisor_id"
end
