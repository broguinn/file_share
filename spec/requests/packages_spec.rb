require 'spec_helper'

describe 'New Package' do
  before do
    @package = FactoryGirl.build(:package)
    @attachment = FactoryGirl.build(:img_attachment)
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

  it 'the user is redirected to the package show page', js: true do
    click_link 'Add an attachment'
    attach_file('Attach File', File.join(Rails.root, '/spec/photos/test.png'))
    click_button 'submit'
    page.should have_content @package.message
    page.should have_content @package.user_name
    page.should have_content 'test.png'
  end
end
