class AddFavoritesCountToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :favorites_count, :integer
  end
end
