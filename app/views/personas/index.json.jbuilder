json.array!(@personas) do |persona|
  json.extract! persona, :id, :rut, :dv, :tipo, :estado, :razonsocial, :alias, :nacionalidad, :direccion, :email, :contacto, :user
  json.url persona_url(persona, format: :json)
end
