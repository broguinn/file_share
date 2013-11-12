class Recipient < ActiveRecord::Base
  belongs_to :package

  validates :email, presence: true
end
