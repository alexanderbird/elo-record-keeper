class CreateGametypes < ActiveRecord::Migration
  def change
    create_table :gametypes do |t|
      t.string :name
      t.integer :number_of_teams
      t.integer :players_per_team

      t.timestamps
    end
    change_column :games, :type, :gametype_id
  end
end
