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

ActiveRecord::Schema.define(version: 20161222123956) do

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.string   "data_fingerprint"
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "games", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "logo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leagues", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "logo_url"
    t.integer  "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_leagues_on_game_id"
    t.index ["name"], name: "index_leagues_on_name"
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "game_id"
    t.datetime "datetime",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "league_id"
    t.index ["datetime"], name: "index_matches_on_datetime"
    t.index ["game_id"], name: "index_matches_on_game_id"
    t.index ["league_id"], name: "index_matches_on_league_id"
  end

  create_table "team_matches", force: :cascade do |t|
    t.integer  "match_id",   null: false
    t.integer  "team_id",    null: false
    t.integer  "score",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "datetime"
    t.index ["match_id"], name: "index_team_matches_on_match_id"
    t.index ["team_id"], name: "index_team_matches_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "logo_url"
    t.integer  "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_teams_on_game_id"
    t.index ["name"], name: "index_teams_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "superadmin_role",        default: false
    t.boolean  "author_role",            default: false
    t.boolean  "user_role",              default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
