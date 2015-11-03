class CreateOutfits < ActiveRecord::Migration
  def change
    create_table :outfits do |t|
      t.string :title
      t.text :description
      t.float :price
      t.string :size
      t.string :type
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
