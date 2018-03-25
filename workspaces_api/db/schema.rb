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

ActiveRecord::Schema.define(version: 20180324025534) do

  create_table "addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "latitude"
    t.string "longitude"
    t.bigint "workspace_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workspace_id"], name: "index_addresses_on_workspace_id"
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.text "content"
    t.integer "rating"
    t.bigint "user_id"
    t.bigint "workspace_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_comments_on_user_id"
    t.index ["workspace_id"], name: "index_comments_on_workspace_id"
  end

  create_table "convenients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "workspace_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_favorites_on_user_id"
    t.index ["workspace_id"], name: "index_favorites_on_workspace_id"
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "status"
    t.datetime "time_start"
    t.datetime "time_end"
    t.string "office_type"
    t.integer "quantity"
    t.bigint "user_id"
    t.bigint "workspace_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
    t.index ["workspace_id"], name: "index_orders_on_workspace_id"
  end

  create_table "types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.integer "quantity"
    t.integer "quantity_desk"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "username"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.date "birthday"
    t.integer "role"
    t.string "avatar"
    t.integer "gender"
    t.string "confirm_token"
    t.datetime "confirm_at"
    t.datetime "confirm_send"
    t.string "provider"
    t.string "uid"
    t.string "oauth_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_reset_token"
  end

  create_table "workspace_convenients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "convenient_id"
    t.bigint "workspace_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["convenient_id"], name: "index_workspace_convenients_on_convenient_id"
    t.index ["workspace_id"], name: "index_workspace_convenients_on_workspace_id"
  end

  create_table "workspace_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "images"
    t.bigint "workspace_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workspace_id"], name: "index_workspace_images_on_workspace_id"
  end

  create_table "workspace_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "workspace_id"
    t.bigint "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type_id"], name: "index_workspace_types_on_type_id"
    t.index ["workspace_id"], name: "index_workspace_types_on_workspace_id"
  end

  create_table "workspaces", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "avatar"
    t.string "address"
    t.string "country"
    t.string "city"
    t.string "district"
    t.string "street"
    t.text "description"
    t.integer "rating"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "friendly_url"
    t.string "price_hour"
    t.string "price_day"
    t.string "price_week"
    t.string "price_month"
    t.string "price_year"
    t.string "unit"
    t.string "open_mon"
    t.string "open_tue"
    t.string "open_wed"
    t.string "open_thurs"
    t.string "open_fri"
    t.string "open_sat"
    t.string "open_sun"
    t.index ["user_id"], name: "index_workspaces_on_user_id"
  end

  add_foreign_key "addresses", "workspaces"
  add_foreign_key "comments", "users"
  add_foreign_key "comments", "workspaces"
  add_foreign_key "favorites", "users"
  add_foreign_key "favorites", "workspaces"
  add_foreign_key "orders", "users"
  add_foreign_key "orders", "workspaces"
  add_foreign_key "workspace_convenients", "convenients"
  add_foreign_key "workspace_convenients", "workspaces"
  add_foreign_key "workspace_images", "workspaces"
  add_foreign_key "workspace_types", "types"
  add_foreign_key "workspace_types", "workspaces"
  add_foreign_key "workspaces", "users"
end
