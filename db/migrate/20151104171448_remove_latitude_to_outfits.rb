class RemoveLatitudeToOutfits < ActiveRecord::Migration
  def change
    remove_column :outfits, :latitude, :float
  end
end
