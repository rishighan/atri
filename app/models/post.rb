class Post < ActiveRecord::Base
    has_many :attachments, as: :imageable, dependent: :destroy
    accepts_nested_attributes_for :attachments, allow_destroy: true

    has_and_belongs_to_many :categories, join_table: :categories_posts
    accepts_nested_attributes_for :categories

end
