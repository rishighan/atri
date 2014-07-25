class Post < ActiveRecord::Base
    has_many :attachments, as: :imageable, dependent: :destroy
    has_and_belongs_to_many :categories
    accepts_nested_attributes_for :attachments
end
