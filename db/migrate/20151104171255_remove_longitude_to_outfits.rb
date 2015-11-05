class RemoveLongitudeToOutfits < ActiveRecord::Migration
  def change
    remove_column :outfits,:longitude,:float
  end
end
