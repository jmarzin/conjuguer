json.array!(@conjugaisons) do |conjugaison|
  json.extract! conjugaison, :id, :infinitif, :essais, :detail
  json.url conjugaison_url(conjugaison, format: :json)
end
