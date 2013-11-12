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

  scenario 'a user successfully creates a package with a file and recipient', js: true do
    fill_in 'Name', with: @sender.name
    fill_in 'Email', with: @sender.email
    fill_in 'Message', with: @package.message
    click_link 'Add a recipient'
    fill_in 'Recipient Email', with: @recipient.email
    click_link 'Add an attachment'
    attach_file('Attach File', File.join(Rails.root, '/spec/photos/test.png'))
    click_button 'submit'
    save_and_open_page
    page.should have_content 'Files Sent!'
  end
end
