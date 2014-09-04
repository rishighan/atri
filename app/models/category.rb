class Category < ActiveRecord::Base
    include FriendlyId
    has_and_belongs_to_many :posts

end
