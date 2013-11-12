require 'spec_helper'

describe Package do
  it { should belong_to :sender }
  it { should have_many :recipients }
  it { should have_many :attachments }

  it { should validate_presence_of :message }
  it { should validate_presence_of :recipients }
  it { should validate_presence_of :encrypted_token }

  it { should accept_nested_attributes_for :sender}
  it { should accept_nested_attributes_for :recipients}
  it { should accept_nested_attributes_for :attachments}
end
