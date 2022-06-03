class DropAlumnosCursos < ActiveRecord::Migration[7.0]
  def change
    drop_table :alumnos_cursos
  end
end
