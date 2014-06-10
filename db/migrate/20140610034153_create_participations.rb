class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :game_id
      t.integer :player_id
      t.integer :team_number
      t.integer :score

      t.timestamps
    end
  end
end
