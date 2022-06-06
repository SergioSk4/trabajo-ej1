class AddNotasPromedio < ActiveRecord::Migration[7.0]
  def change
    add_column :notas, :promedio, :decimal
  end
end
