class AddIsDraftToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :is_draft, :string
  end
end
