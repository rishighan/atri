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
  before_save :check_dimensions
  serialize :dimensions

  def check_dimensions
    tempfile = picture.queued_for_write[:original]
    unless tempfile.nil?
        geometry = Paperclip::Geometry.from_file(tempfile)
        self.dimensions = [geometry.width.to_i, geometry.height.to_i]
  end
end
end

