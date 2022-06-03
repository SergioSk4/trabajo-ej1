class CreateNotas < ActiveRecord::Migration[7.0]
  def change
    create_table :notas do |t|
      t.references :curso, null: false, foreign_key: true
      t.references :alumno, null: false, foreign_key: true
      t.decimal :parcial1
      t.decimal :parcial2
      t.decimal :zona
      t.decimal :examen
      t.decimal :total

      t.timestamps
    end
  end
end
