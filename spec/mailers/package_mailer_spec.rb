require "spec_helper"

feature 'PackageMailer' do
  before do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    @package = FactoryGirl.build(:package)
    @token = SecureRandom.base64
    @package.encrypted_token = BCrypt::Password.create(@token)
  end

  context 'recipient receives an email' do
    before do
      PackageMailer.recipient_email(@package, @token).deliver
    end

    scenario 'an email is sent' do
      ActionMailer::Base.deliveries.count.should eq 1
    end

    scenario 'it sends to the right email' do
      ActionMailer::Base.deliveries.first.to.should eq [@package.recipient_email]
    end

    scenario 'it gives the right subject line' do
      ActionMailer::Base.deliveries.first.subject.should eq 'Your File Share Package is Ready'
    end

    scenario 'Email gives instructions' do
      first_delivery = ActionMailer::Base.deliveries.first
      first_delivery.body.raw_source.should have_content "#{@package.user_name} has shared a file with you"
    end

    scenario 'Email includes personal message' do
      first_delivery = ActionMailer::Base.deliveries.first
      first_delivery.body.raw_source.should have_content "#{@package.message}"      
    end

    scenario 'Email includes a link with a unique token' do
      first_delivery = ActionMailer::Base.deliveries.first
      first_delivery.body.raw_source.should have_content 'You can download them here'
    end

    scenario 'Email includes information on 72 hour access' do
      first_delivery = ActionMailer::Base.deliveries.first
      first_delivery.body.raw_source.should have_content "These files will remain available for the next 72 hours, after which they will be deleted."      
    end
  end

  context 'sender receives an email' do
    before do
      PackageMailer.sender_email(@package).deliver
    end

    scenario 'an email is sent' do
      ActionMailer::Base.deliveries.count.should eq 1
    end

    scenario 'it sends to the right email' do
      ActionMailer::Base.deliveries.first.to.should eq [@package.user_email]
    end

    scenario 'it gives the right subject line' do
      ActionMailer::Base.deliveries.first.subject.should eq 'Your Files Were Accessed'
    end

    scenario 'Email gives confirmation' do
      first_delivery = ActionMailer::Base.deliveries.first
      first_delivery.body.raw_source.should have_content "The recipient has downloaded the files"
    end

    scenario 'Email includes info on how long until the package is removed' do
      first_delivery = ActionMailer::Base.deliveries.first
      first_delivery.body.raw_source.should have_content "The package will be removed in "      
    end
  end

  after do
    ActionMailer::Base.deliveries.clear
  end
end
