include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :package do
    message 'Here\'s the blog picture and content.'
  end

  factory :sender do
    name 'John Doe'
    email 'jd@example.com'
  end

  factory :img_attachment do
    file { fixture_file_upload(Rails.root.join('spec', 'photos', 'test.png'), 'image/png') }
  end

  factory :txt_attachment do
    file { fixture_file_upload(Rails.root.join('spec', 'texts', 'test.rtf'), 'image/png') }
  end

  factory :recipient do
    sequence(:email) { |n| "recipient#{n}@example.com" } 
  end
end
