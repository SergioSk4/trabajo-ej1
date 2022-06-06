class AddBimestreToNotas < ActiveRecord::Migration[7.0]
  def change
    add_column :notas, :bimestre, :integer
  end
end
