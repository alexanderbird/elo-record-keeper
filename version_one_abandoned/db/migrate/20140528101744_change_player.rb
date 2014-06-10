class ChangePlayer < ActiveRecord::Migration
  def change
    change_column :players, :rating, :integer
  end
end
