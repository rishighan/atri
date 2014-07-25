class CreateAttachments < ActiveRecord::Migration
  def up
    create_table :attachments do |t|
      t.references :imageable, polymorphic: true, index: true
    end
  end

  def down
    change_table :attachments do |t|
      t.remove_references :imageable, polymorphic: true, index: true
    end
  end
end
