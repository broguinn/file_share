class Attachment < ActiveRecord::Base
  belongs_to :package

  validates :file_name, presence: true
  validates :file_type, presence: true
  has_attached_file :file
  validates_attachment_presence :file
end
