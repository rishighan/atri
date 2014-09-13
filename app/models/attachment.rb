class Attachment < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :imageable, polymorphic: true
  has_attached_file :picture,
                     styles:  lambda { |a| a.instance.check_file_type},
                    # per paperclip documentation, this path survives during capistrano deployment
                    # and hence I am keeping it.
                    :url => "/system/attachments/:attachment/:id_partition/:style/:filename",
                    :path =>"#{Rails.root}/public/system/:class/:attachment/:id_partition/:style/:filename"
  validates_attachment_content_type :picture, :content_type => [/\Aimage\/.*\Z/, /\Avideo\/.*\Z/, /\Aaudio\/.*\Z/, /\Aapplication\/.*\Z/]

  def check_file_type
    if is_image_type?
      {:thumb => "150x", :medium => "660x"}
    end
  end

  # check for content types
  def is_image_type?
    picture_content_type =~ %r(image)
  end

end

