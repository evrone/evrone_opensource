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

ActiveRecord::Schema.define(version: 2020_07_20_232726) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "project_improvements", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.citext "internal_pull_request_url", comment: "References internal PR inside the forked project"
    t.citext "external_pull_request_url", comment: "References PR to the original project"
    t.integer "github_author_id", comment: "Who done the review (and responsible to get PR merged to the original project)"
    t.string "status", default: "awaiting_review", comment: "stage of the improvement till it get merged"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["external_pull_request_url"], name: "index_project_improvements_on_external_pull_request_url", unique: true
    t.index ["internal_pull_request_url"], name: "index_project_improvements_on_internal_pull_request_url", unique: true
    t.index ["project_id"], name: "index_project_improvements_on_project_id"
    t.index ["status"], name: "index_project_improvements_on_status"
  end

  create_table "projects", force: :cascade do |t|
    t.citext "repository_name", comment: "Repository name at GitHub"
    t.citext "internal_repository_name", comment: "Forked repository name at GitHub"
    t.datetime "handled_at", comment: "When original repository was scaned for improvement opportunities"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["handled_at"], name: "index_projects_on_handled_at", where: "(handled_at IS NULL)"
    t.index ["internal_repository_name"], name: "index_projects_on_internal_repository_name", unique: true
    t.index ["repository_name"], name: "index_projects_on_repository_name", unique: true
  end

  add_foreign_key "project_improvements", "projects"
end
