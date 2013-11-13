 require 'spec_helper'

describe 'New Package' do
  before do
    @package = FactoryGirl.build(:package)
    visit root_path
    click_link 'Yes'
    fill_in 'Name', with: @package.user_name
    fill_in 'Email', with: @package.user_email
    fill_in 'Message', with: @package.message
    fill_in 'Recipient Email', with: @package.recipient_email
  end

  it 'the user receives a flash notice that their files were sent', js: true do
    click_link 'Add an attachment'
    attach_file('Attach File', File.join(Rails.root, '/spec/photos/test.png'))
    click_button 'submit'
    page.should have_content 'Files Sent!'
  end

  it 'the user receives a flash notice that their files were sent', js: true do
    click_button 'submit'
    page.should_not have_content 'Files Sent!'
  end
end

describe 'Package View' do
  before do
    include ActionView::Helpers
    @package = FactoryGirl.create(:package)
    @token = SecureRandom.base64
    @package.encrypted_token = BCrypt::Password.create(@token)
    @package.save 
  end

  it 'redirects the user if their token is not authentic' do
    @token = 'foobar'
    visit package_path(@package, token: @token)
    page.should have_content 'Access denied'
  end

  it 'displays information about each attachment' do
    visit package_path(@package, token: @token)
    @package.attachments.each do |attachment|
      page.should have_content attachment.file_file_name
      page.should have_content attachment.file_file_size
      page.should have_content attachment.file_content_type
    end
  end

  it 'provides a link for each attachment' do
    visit package_path(@package, token: @token)
    @package.attachments.each do |attachment|
  end
end
