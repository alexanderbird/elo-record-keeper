class ChangeGameForeignKey < ActiveRecord::Migration
  def change
    rename_column :games, :gametype, :game_type_id
  end
end
