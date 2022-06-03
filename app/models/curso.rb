class Curso < ApplicationRecord
    has_many :alumnos_cursos, dependent: :destroy
    has_many :alumnos, through: :alumnos_cursos

    has_many :notas, :dependent => :destroy

    
    validates :nombre, presence: true
    validates :profesor, presence: true
end
