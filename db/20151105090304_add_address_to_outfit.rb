class AddAddressToOutfit < ActiveRecord::Migration
  def change
    add_column :outfits, :address, :string
  end
end
