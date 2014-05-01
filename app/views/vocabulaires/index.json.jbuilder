json.array!(@vocabulaires) do |vocabulaire|
  json.extract! vocabulaire, :id, :francais, :italien
  json.url vocabulaire_url(vocabulaire, format: :json)
end
