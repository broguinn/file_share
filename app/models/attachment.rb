class Attachment < ActiveRecord::Base
  belongs_to :package

  validates :file_name, presence: true
  validates :file_type, presence: true
end
