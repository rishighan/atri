class Attachment < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :imageable, polymorphic: true
  has_attached_file :picture,
                    :styles =>{ :medium => "660x",
                                :thumb => "150x"
                    },
                    :url => "/attachments/pictures/:style/:basename.:extension",
                    :path =>"#{Rails.root}/public/attachments/pictures/:style/:basename.:extension"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

end

