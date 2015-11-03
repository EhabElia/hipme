class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :outfits, :type, :styles
  end
end
