class Alumno < ApplicationRecord
    has_many :alumnos_cursos, dependent: :destroy
    has_many :cursos, through: :alumnos_cursos
end
