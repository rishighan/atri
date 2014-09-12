class Attachment < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :imageable, polymorphic: true
  has_attached_file :picture,
                    :styles =>{ :medium => "660x",
                                :thumb => "150x"
                    },
                    # per paperclip documentation, this path survives during capistrano deployment
                    # and hence I am keeping it.
                    :url => "/system/attachments/:attachment/:id_partition/:style/:filename",
                    :path =>"#{Rails.root}/public/system/:class/:attachment/:id_partition/:style/:filename"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

end

