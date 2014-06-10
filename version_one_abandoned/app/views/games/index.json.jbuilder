json.array!(@games) do |game|
  json.extract! game, :id, :date, :type, :number_of_players, :data
  json.url game_url(game, format: :json)
end
