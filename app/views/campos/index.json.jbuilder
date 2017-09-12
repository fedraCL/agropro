json.array!(@campos) do |campo|
  json.extract! campo, :id, :nombre
  json.url campo_url(campo, format: :json)
end
