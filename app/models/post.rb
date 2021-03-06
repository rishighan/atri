class Post < ActiveRecord::Base
    include FriendlyId

    # pagination
    paginates_per 10

    #autocomplete support
    searchkick autocomplete: ['title']

    friendly_id :title, use:[:slugged, :I18n, :finders]
    validates :title, presence: true
    validates :content, presence: true
    validates :excerpt, presence: true

    has_many :attachments, as: :imageable, dependent: :destroy
    accepts_nested_attributes_for :attachments, allow_destroy: true

    has_and_belongs_to_many :categories, join_table: :categories_posts
    accepts_nested_attributes_for :categories

    #named scope that isolates "heroes" and "projects"
    scope :hero, -> {Post.group_by_category("exactly", ["Hero"])}
    scope :projects, -> {Post.group_by_category("exactly", ["Projects"])}
    scope :desc, -> {Post.order("posts.created_at DESC")}
    #scope :highlights, -> {Post.group_by_category("exactly", ["Highlight"])}

    #filter posts by category
    def self.group_by_category(action,category)
        case action
        when "include"
         post = Post.includes(:categories).where('categories.title IN (?)', category).references(:categories)

        when "exclude"
         post = Post.includes(:categories).where('categories.title NOT IN (?)', category).references(:categories)

        when "exactly"
         post = Post.includes(:categories).where('categories.title = (?)', category).references(:categories)

        else
         post = Post.all
        end
    end

    #check if draft
    def self.is_draft(what)
        post = Post.where('is_draft = (?)', what )
    end

    #category selection
    def self.check_category(cats)
      result = []
      cats.each do |cat|
        result << Category.where("title = ?", cat).select("id").first
      end
      result.map(&:id)
    end


end
