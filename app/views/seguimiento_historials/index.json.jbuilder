json.array!(@seguimiento_historials) do |seguimiento_historial|
  json.extract! seguimiento_historial, :id, :id_origen, :codigo, :naviera, :nave, :pol, :pod, :etd, :eta, :countchange, :user
  json.url seguimiento_historial_url(seguimiento_historial, format: :json)
end
