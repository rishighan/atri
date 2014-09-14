class Attachment < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :imageable, polymorphic: true
  has_attached_file :picture,
                     styles: lambda { |a| a.instance.is_image? ? {:thumb => "150x", :medium => "550x"} : {}},

                    # per paperclip documentation, this path survives during capistrano deployment
                    # and hence I am keeping it.
                    :url => "/system/attachments/:attachment/:id_partition/:style/:filename",
                    :path =>"#{Rails.root}/public/system/:class/:attachment/:id_partition/:style/:filename"
  validates_attachment_content_type :picture, :content_type => [/\Aimage\/.*\Z/, /\Avideo\/.*\Z/, /\Aaudio\/.*\Z/, /\Aapplication\/.*\Z/]


  # checks if the instance of attachment is an image
  # if it is, proceeds with generating different styles
    def is_image?
        picture.instance.picture_content_type =~ %r(image)
    end

end

