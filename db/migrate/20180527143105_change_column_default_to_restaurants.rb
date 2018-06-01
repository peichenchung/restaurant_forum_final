class ChangeColumnDefaultToRestaurants < ActiveRecord::Migration[5.2]
  def change
    change_column_default :restaurants, :favorites_count, 0
  end
end
