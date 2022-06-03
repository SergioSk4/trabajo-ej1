class AlumnosCurso < ApplicationRecord
  belongs_to :curso
  belongs_to :alumno
end
