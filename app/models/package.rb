class Package < ActiveRecord::Base
  has_many :attachments, dependent: :destroy

  before_create :set_encrypted_token
  after_create :send_recipient_email

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

  def hours_left
    72 - ((Time.now - created_at) / 1.hour).round
  end

private

  def validate_attachments
    errors.add(:attachments, 'You must attach at least one file') if attachments.length < 1
  end

  def set_encrypted_token
    @token = SecureRandom.base64
    self.encrypted_token = BCrypt::Password.create(@token)
  end

  def send_recipient_email
    PackageMailer.recipient_email(self, @token).deliver
  end
end
