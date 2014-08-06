class Post < ActiveRecord::Base

    validates :title, presence: true
    validates :content, presence: true
    validates :excerpt, presence: true

    has_many :attachments, as: :imageable, dependent: :destroy
    accepts_nested_attributes_for :attachments, allow_destroy: true

    has_and_belongs_to_many :categories, join_table: :categories_posts
    accepts_nested_attributes_for :categories

    #filter posts by category
    def self.group_by_category(action,category)
        case action
        when "include"
         post = Post.includes(:categories).where('categories.title IN (?)', category).order(created_at: :desc)

        when "exclude"
         post = Post.includes(:categories).where('categories.title NOT IN (?)', category)

         else
         post = Post.all
        end
    end

    def self.is_draft(what)
        post = Post.where('is_draft = (?)', what )
    end

end
