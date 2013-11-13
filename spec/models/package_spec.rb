require 'spec_helper'

describe Package do
  it { should have_many :attachments }
  it { should validate_presence_of :message }
  it { should validate_presence_of :recipient_email }
  it { should validate_presence_of :user_email }

  it { should accept_nested_attributes_for :attachments }
  it { should respond_to :authenticate }

  describe '#authenticate' do
    it 'returns true if the remember token passed in matches the encrypted token in the DB' do
      @token = 'foobars'
      @package = FactoryGirl.create(:package)
      @package.encrypted_token = BCrypt::Password.create(@token)
      @package.authenticate(@token).should be_true
    end
  end

  # describe '#link' do
  #   it 'returns a url to the package with the unencrypted token in params' do
  #     @token = 'foobars'
  #     @package = FactoryGirl.create(:package)
  #     @package.link(@token).should eq link_to({ token: @token })
  #   end
  # end
end
