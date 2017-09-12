json.array!(@cuarteles) do |cuartele|
  json.extract! cuartele, :id, :nombre
  json.url cuartele_url(cuartele, format: :json)
end
