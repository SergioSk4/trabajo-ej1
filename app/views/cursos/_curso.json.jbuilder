json.extract! curso, :id, :nombre, :profesor, :created_at, :updated_at
json.url curso_url(curso, format: :json)
