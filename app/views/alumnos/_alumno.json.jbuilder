json.extract! alumno, :id, :nombre, :grado, :edad, :created_at, :updated_at
json.url alumno_url(alumno, format: :json)
