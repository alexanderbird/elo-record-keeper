class ChangePlayers < ActiveRecord::Migration
  def change
    add_column :players, :team, :integer
  end
end
