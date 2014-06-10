json.array!(@game_types) do |game_type|
  json.extract! game_type, :id, :name, :number_of_teams, :players_per_team
  json.url game_type_url(game_type, format: :json)
end
