class Category < ActiveRecord::Base
    has_and_belongs_to_many :posts
    validates :title, presence: true
    validates :description, presence: true

end
