class AddAttachmentPictureToCars < ActiveRecord::Migration
  def self.up
    change_table :cars do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :cars, :picture
  end
end
