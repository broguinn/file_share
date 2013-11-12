require 'spec_helper'

feature 'New Package' do
  before do
    @sender = FactoryGirl.build(:sender)
    @package = FactoryGirl.build(:package)
    @attachment = FactoryGirl.build(:img_attachment)
    @recipient = FactoryGirl.build(:recipient)
    visit root_path
    click_link 'Yes'
  end

  scenario 'a user successfully creates a package with a file and recipient' do
    fill_in 'Name', with: @sender.name
    fill_in 'Email', with: @sender.email
    fill_in 'Recipient Email', with: @recipient.email
    fill_in 'Message', with: @package.message
    attach_file 'File', with: @attachment.file
    click_button 'Upload'
    page.should have_content 'Files Sent!'
  end
end