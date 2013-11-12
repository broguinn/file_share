class Package < ActiveRecord::Base
  belongs_to :sender
  has_many :recipients
  has_many :attachments

  validates :message, presence: true
end
