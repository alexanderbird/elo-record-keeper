# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
GameType.destroy_all
GameType.create(
  name:               "One on One",
  number_of_teams:    2,
  players_per_team:   1,
  )
GameType.create(
  name:               "Free for all 3",
  number_of_teams:    3,
  players_per_team:   1,
  )
GameType.create(
  name:               "Free for all 4",
  number_of_teams:    4,
  players_per_team:   1,
  )
GameType.create(
  name:               "Free for all 5",
  number_of_teams:    5,
  players_per_team:   1,
  )
GameType.create(
  name:               "Two Headed Giant",
  number_of_teams:    2,
  players_per_team:   2,
  )
GameType.create(
  name:               "Old Skool - Team 2 on 2",
  number_of_teams:    2,
  players_per_team:   2,
  )
