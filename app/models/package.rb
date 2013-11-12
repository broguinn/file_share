class Package < ActiveRecord::Base
  belongs_to :sender
  has_many :recipients
  has_many :attachments

  validates :message, presence: true
  validates :recipients, presence: true
  validates :encrypted_token, presence: true

  accepts_nested_attributes_for :sender
  accepts_nested_attributes_for :recipients
  accepts_nested_attributes_for :attachments,
                                reject_if: lambda { |a| a[:file].blank? },
                                :allow_destroy => true
end
