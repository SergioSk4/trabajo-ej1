class ChangeEstadoNotaType < ActiveRecord::Migration[7.0]
  def change
    change_column :notas, :estado_cierre, :string
  end
end
