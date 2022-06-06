class AddEstadoPromedioNotas < ActiveRecord::Migration[7.0]
  def change
    add_column :notas, :estado_cierre, :boolean
  end
end
