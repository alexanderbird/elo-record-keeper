class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.boolean :pro
      t.decimal :rating
      t.decimal :k_factor

      t.timestamps
    end
  end
end
