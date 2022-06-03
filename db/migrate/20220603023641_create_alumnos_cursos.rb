class CreateAlumnosCursos < ActiveRecord::Migration[7.0]
  def change
    create_table :alumnos_cursos do |t|
      t.belongs_to :curso, null: false, foreign_key: true
      t.belongs_to :alumno, null: false, foreign_key: true

      t.timestamps
    end
  end
end
