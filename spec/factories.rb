include ActionDispatch::TestProcess

@token = SecureRandom.base64

FactoryGirl.define do
  factory :attachment do
    factory :img_attachment do
      file { fixture_file_upload(Rails.root.join('spec', 'photos', 'test.png'), 'image/png') }
    end

    factory :txt_attachment do
      file { fixture_file_upload(Rails.root.join('spec', 'texts', 'test.rtf'), 'text/rtf') }
    end
  end

  factory :package do
    message 'Here\'s the blog picture and content.'
    user_name 'John Doe'
    user_email 'jd@example.com'
    recipient_email "recipient@example.com"
    encrypted_token BCrypt::Password.create(@token)
    attachments_attributes [FactoryGirl.attributes_for(:img_attachment), FactoryGirl.attributes_for(:txt_attachment)]
  end
end
