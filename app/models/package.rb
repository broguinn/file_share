class Package < ActiveRecord::Base
  has_many :attachments

  before_create :set_encrypted_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :message, presence: true
  validates :user_email, 
            presence: true,
            format: { with: VALID_EMAIL_REGEX }
  validates :recipient_email, 
            presence: true,
            format: { with: VALID_EMAIL_REGEX }
  validate :validate_attachments

  accepts_nested_attributes_for :attachments,
                                reject_if: :all_blank,
                                allow_destroy: true

  def authenticate(token)
    BCrypt::Password.new(encrypted_token) == token
  end

private

  def validate_attachments
    errors.add(:attachments, 'You must attach at least one file') if attachments.length < 1
  end

  def set_encrypted_token
    # cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    @token = SecureRandom.base64
    self.encrypted_token = BCrypt::Password.create(@token)
  end
end
