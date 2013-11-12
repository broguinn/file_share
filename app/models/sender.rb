class Sender < ActiveRecord::Base
  has_many :packages

  validates :name, presence: true
  validates :email, presence: true
end
