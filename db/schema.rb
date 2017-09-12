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

ActiveRecord::Schema.define(version: 20170912042108) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campos", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "persona_id"
  end

  add_index "campos", ["persona_id"], name: "index_campos_on_persona_id", using: :btree

  create_table "cuarteles", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "campo_id"
  end

  add_index "cuarteles", ["campo_id"], name: "index_cuarteles_on_campo_id", using: :btree

  create_table "mantenedors", force: true do |t|
    t.string   "tipo"
    t.string   "valor"
    t.string   "misc"
    t.string   "codigo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "personas", force: true do |t|
    t.string   "rut"
    t.string   "dv"
    t.string   "tipo"
    t.string   "estado"
    t.string   "razonsocial"
    t.string   "alias"
    t.string   "nacionalidad"
    t.string   "direccion"
    t.string   "email"
    t.string   "contacto"
    t.string   "user"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "campo_id"
  end

  add_index "personas", ["campo_id"], name: "index_personas_on_campo_id", using: :btree

  create_table "ports", force: true do |t|
    t.string   "pais"
    t.string   "port"
    t.string   "codigo"
    t.string   "lat_long"
    t.string   "telefono"
    t.string   "web"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rols", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seguimiento_historials", force: true do |t|
    t.integer  "id_origen"
    t.string   "codigo"
    t.string   "naviera"
    t.string   "nave"
    t.string   "pol"
    t.string   "pod"
    t.string   "etd"
    t.string   "eta"
    t.integer  "countchange"
    t.string   "user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seguimientos", force: true do |t|
    t.string   "codigo"
    t.string   "naviera"
    t.string   "nave"
    t.string   "pol"
    t.string   "pod"
    t.string   "etd"
    t.string   "eta"
    t.integer  "countchange"
    t.string   "user"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "latitud"
    t.string   "longitud"
  end

  create_table "statuses", force: true do |t|
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "statuses", ["user_id"], name: "index_statuses_on_user_id", using: :btree

  create_table "user_friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_friendships", ["user_id", "friend_id"], name: "index_user_friendships_on_user_id_and_friend_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "profile_name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vessels", force: true do |t|
    t.string   "nombre"
    t.string   "imo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
