json.array!(@gametypes) do |gametype|
  json.extract! gametype, :id, :name, :number_of_teams, :players_per_team
  json.url gametype_url(gametype, format: :json)
end
