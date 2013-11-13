class Attachment < ActiveRecord::Base
  belongs_to :package

  has_attached_file :file
  validates_attachment_presence :file

  def send_sender_email
    PackageMailer.sender_email(package).deliver
  end
end
