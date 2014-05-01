json.array!(@vocabulaires) do |vocabulaire|
  json.extract! vocabulaire, :id, :mot_directeur, :francais, :compteur, :italien
  json.url vocabulaire_url(vocabulaire, format: :json)
end
