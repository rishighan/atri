class Post < ActiveRecord::Base
    include FriendlyId
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    # this is to map search keywords
    settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
        indexes :title, analyzer: 'english'
        indexes :content, analyzer: 'english'
    end
    end

    friendly_id :title, use:[:slugged, :I18n]
    validates :title, presence: true
    validates :content, presence: true
    validates :excerpt, presence: true

    has_many :attachments, as: :imageable, dependent: :destroy
    accepts_nested_attributes_for :attachments, allow_destroy: true

    has_and_belongs_to_many :categories, join_table: :categories_posts
    accepts_nested_attributes_for :categories

    #scope that isolates "heroes" and "projects"
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
         post = Post.includes(:categories).where('categories.title = (?)', category)

        else
         post = Post.all
        end
    end

    def self.is_draft(what)
        post = Post.where('is_draft = (?)', what )
    end

        # Delete the previous articles index in Elasticsearch
    Post.__elasticsearch__.client.indices.delete index: Post.index_name rescue nil

    # Create the new index with the new mapping
    Post.__elasticsearch__.client.indices.create \
      index: Post.index_name,
      body: { settings: Post.settings.to_hash, mappings: Post.mappings.to_hash }

    # Index all article records from the DB to Elasticsearch
    Post.import


end
