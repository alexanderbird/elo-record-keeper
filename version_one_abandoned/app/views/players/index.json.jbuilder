json.array!(@players) do |player|
  json.extract! player, :id, :name, :pro, :rating, :k_factor
  json.url player_url(player, format: :json)
end
