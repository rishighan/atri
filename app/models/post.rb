class Post < ActiveRecord::Base

    validates :title, presence: true
    validates :content, presence: true
    validates :excerpt, presence: true

    has_many :attachments, as: :imageable, dependent: :destroy
    accepts_nested_attributes_for :attachments, allow_destroy: true

    has_and_belongs_to_many :categories, join_table: :categories_posts
    accepts_nested_attributes_for :categories

    #scope that isolates "heroes"
    scope :hero, -> {Post.includes(:categories).where('categories.title = (?)', "Hero")}

    #filter posts by category
    def self.group_by_category(action,category)
        case action
        when "include"
         post = Post.includes(:categories).where('categories.title IN (?)', category).order(created_at: :desc).references(:categories)

        when "exclude"
         post = Post.includes(:categories).where('categories.title NOT IN (?)', category).references(:categories)

        else
         post = Post.all
        end
    end

    def self.is_draft(what)
        post = Post.where('is_draft = (?)', what )
    end

end
