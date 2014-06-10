class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.decimal :value
      t.integer :game_id
      t.integer :player_id

      t.timestamps
    end
  end
end
