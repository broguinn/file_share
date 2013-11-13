require "spec_helper"

feature 'PackageMailer' do
  before do
    ActionMailer::Base.deliveries.clear
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    @package = FactoryGirl.create(:package)
    @token = SecureRandom.base64
    @package.encrypted_token = BCrypt::Password.create(@token)
  end

  context 'recipient receives an email' do
    before do
      ActionMailer::Base.deliveries.clear
      PackageMailer.recipient_email(@package, @token).deliver
    end

    scenario 'an email is sent' do
      ActionMailer::Base.deliveries.count.should eq 1
    end

    scenario 'it sends to the right email' do
      ActionMailer::Base.deliveries.last.to.should eq [@package.recipient_email]
    end

    scenario 'it gives the right subject line' do
      ActionMailer::Base.deliveries.last.subject.should eq 'Your File Share Package is Ready'
    end

    scenario 'Email gives instructions' do
      last_delivery = ActionMailer::Base.deliveries.last
      last_delivery.body.raw_source.should have_content "#{@package.user_name} has shared a file with you"
    end

    scenario 'Email includes personal message' do
      last_delivery = ActionMailer::Base.deliveries.last
      last_delivery.body.raw_source.should have_content "#{@package.message}"      
    end

    scenario 'Email includes a link with a unique token' do
      last_delivery = ActionMailer::Base.deliveries.last
      last_delivery.body.raw_source.should have_content 'You can download them here'
    end

    scenario 'Email includes information on 72 hour access' do
      last_delivery = ActionMailer::Base.deliveries.last
      last_delivery.body.raw_source.should have_content "These files will remain available for the next 72 hours, after which they will be deleted."      
    end

    after do
      ActionMailer::Base.deliveries.clear
    end
  end

  context 'sender receives an email' do
    before do
      ActionMailer::Base.deliveries.clear
      PackageMailer.sender_email(@package).deliver
    end

    scenario 'an email is sent' do
      ActionMailer::Base.deliveries.count.should eq 1
    end

    scenario 'it sends to the right email' do
      ActionMailer::Base.deliveries.last.to.should eq [@package.user_email]
    end

    scenario 'it gives the right subject line' do
      ActionMailer::Base.deliveries.last.subject.should eq 'Your Files Were Accessed'
    end

    scenario 'Email gives confirmation' do
      last_delivery = ActionMailer::Base.deliveries.last
      last_delivery.body.raw_source.should have_content "The recipient has downloaded some of your files."
    end

    scenario 'Email includes info on how long until the package is removed' do
      last_delivery = ActionMailer::Base.deliveries.last
      last_delivery.body.raw_source.should have_content "The package will be removed in #{@package.hours_left} hours."      
    end

    after do
      ActionMailer::Base.deliveries.clear
    end
  end
end
