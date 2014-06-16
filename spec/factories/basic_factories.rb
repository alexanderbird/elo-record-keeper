FactoryGirl.define do
  factory :player do
    name        "Isaac Tester - #{Player.count} #{('a'..'z').to_a.shuffle[0,8].join}"
  end

  factory :game_type do
    name              "Factoried Game Type"
    number_of_teams   3
    players_per_team  1
  end

  factory :game do
    date        Time.now
    game_type   FactoryGirl.create :game_type, name: "Generic Factory-Made Game Type"
  end

  factory :participation do
    player      FactoryGirl.create(:player, name: "Participating Player")
    game        FactoryGirl.create(:game)
    score       1
    team_number 1
  end

end
