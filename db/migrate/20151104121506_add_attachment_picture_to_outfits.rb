class AddAttachmentPictureToOutfits < ActiveRecord::Migration
  def self.up
    change_table :outfits do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :outfits, :picture
  end
end
