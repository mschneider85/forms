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

ActiveRecord::Schema.define(version: 20170310202609) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "citext"

  create_table "campaigns", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.citext   "path"
    t.integer  "status",     default: 0,  null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.jsonb    "settings",   default: {}, null: false
    t.index ["settings"], name: "index_campaigns_on_settings", using: :gin
  end

  create_table "campaigns_users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "campaign_id",             null: false
    t.uuid     "user_id",                 null: false
    t.integer  "role",        default: 0, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["campaign_id"], name: "index_campaigns_users_on_campaign_id", using: :btree
    t.index ["user_id"], name: "index_campaigns_users_on_user_id", using: :btree
  end

  create_table "forms", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.jsonb    "structure",  default: {}, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["slug"], name: "index_forms_on_slug", using: :btree
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.citext   "email",                          null: false
    t.citext   "username"
    t.integer  "role",               default: 0, null: false
    t.string   "login_token"
    t.datetime "token_generated_at"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

end
