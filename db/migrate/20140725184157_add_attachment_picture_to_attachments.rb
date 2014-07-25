class AddAttachmentPictureToAttachments < ActiveRecord::Migration
  def self.up
    change_table :attachments do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :attachments, :picture
  end
end
