json.array!(@games) do |game|
  json.extract! game, :id, :date, :gametype
  json.url game_url(game, format: :json)
end
