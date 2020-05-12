# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_08_170534) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "project_improvements", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.citext "internal_pull_request_url", comment: "References internal PR inside the forked project"
    t.citext "external_pull_request_url", comment: "References PR to the original project"
    t.integer "github_author_id", comment: "Who done the review (and responsible to get PR merged to the original project)"
    t.string "status", comment: "stage of the improvement till it get merged"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_project_improvements_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.citext "repository_url", comment: "Original repository url"
    t.citext "internal_repository_url", comment: "Forked repository url"
    t.datetime "handled_at", comment: "When original repository was scaned for improvement opportunities"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["handled_at"], name: "index_projects_on_handled_at", where: "(handled_at IS NULL)"
    t.index ["internal_repository_url"], name: "index_projects_on_internal_repository_url", unique: true
    t.index ["repository_url"], name: "index_projects_on_repository_url", unique: true
  end

  add_foreign_key "project_improvements", "projects"
end
