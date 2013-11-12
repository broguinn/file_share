class Package < ActiveRecord::Base
  belongs_to :sender
  has_many :recipients
  has_many :attachments

  validates :message, presence: true
  validates :recipients, presence: true
  validates :encrypted_token, presence: true
end
