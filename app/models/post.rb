class Post < ActiveRecord::Base

    validates :title, presence: true
    validates :content, presence: true
    validates :excerpt, presence: true

    has_many :attachments, as: :imageable, dependent: :destroy
    accepts_nested_attributes_for :attachments, allow_destroy: true

    has_and_belongs_to_many :categories, join_table: :categories_posts
    accepts_nested_attributes_for :categories


    def group_by_category(category)
        post = Post.where(categories.title = category)
    end

    def filter_drafts
        post = Post.where(:is_draft)
    end

end
