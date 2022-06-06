class Nota < ApplicationRecord
  belongs_to :curso
  belongs_to :alumno
  validates :parcial1, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 15, only_numeric: true}
  validates :parcial2, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 15, only_numeric: true}
  validates :zona, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 30, only_numeric: true}
  validates :examen, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 40, only_numeric: true}
  validates :bimestre, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 5, only_integer: true}
  validates_uniqueness_of :bimestre, scope: [:curso, :alumno], message: 'ya tiene nota' 


  paginates_per 2

  def self.estados
    %w(Abierto Cerrado)
  end

  def cerrado?
    self.estado_cierre == 'Cerrado'
  end

  def abierto?
    self.estado_cierre == 'Abierto'
  end
  end
