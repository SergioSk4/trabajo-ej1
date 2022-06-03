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

ActiveRecord::Schema[7.0].define(version: 2022_06_03_152542) do
  create_table "alumnos", force: :cascade do |t|
    t.string "nombre"
    t.integer "grado"
    t.integer "edad"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "alumnos_cursos", force: :cascade do |t|
    t.integer "curso_id", null: false
    t.integer "alumno_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alumno_id"], name: "index_alumnos_cursos_on_alumno_id"
    t.index ["curso_id"], name: "index_alumnos_cursos_on_curso_id"
  end

  create_table "cursos", force: :cascade do |t|
    t.string "nombre"
    t.string "profesor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notas", force: :cascade do |t|
    t.integer "curso_id", null: false
    t.integer "alumno_id", null: false
    t.decimal "parcial1"
    t.decimal "parcial2"
    t.decimal "zona"
    t.decimal "examen"
    t.decimal "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "bimestre"
    t.index ["alumno_id"], name: "index_notas_on_alumno_id"
    t.index ["curso_id"], name: "index_notas_on_curso_id"
  end

  add_foreign_key "alumnos_cursos", "alumnos"
  add_foreign_key "alumnos_cursos", "cursos"
  add_foreign_key "notas", "alumnos"
  add_foreign_key "notas", "cursos"
end
