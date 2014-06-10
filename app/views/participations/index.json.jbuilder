json.array!(@participations) do |participation|
  json.extract! participation, :id, :game_id, :player_id, :team_number, :score
  json.url participation_url(participation, format: :json)
end
