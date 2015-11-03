class FixColumnNameSingular < ActiveRecord::Migration
  def change
    rename_column :outfits, :styles, :style
  end
end
