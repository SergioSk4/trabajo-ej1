class Alumno < ApplicationRecord
    has_many :alumnos_cursos, dependent: :destroy
    has_many :cursos, through: :alumnos_cursos

    has_many :notas, :dependent => :destroy

    paginates_per 7
end
