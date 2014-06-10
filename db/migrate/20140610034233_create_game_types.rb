class CreateGameTypes < ActiveRecord::Migration
  def change
    create_table :game_types do |t|
      t.string :name
      t.integer :number_of_teams
      t.integer :players_per_team

      t.timestamps
    end
  end
end
