class AddCoordinatesToOutfit < ActiveRecord::Migration
  def change
    add_column :outfits, :latitude, :float
    add_column :outfits, :longitude, :float
  end
end
