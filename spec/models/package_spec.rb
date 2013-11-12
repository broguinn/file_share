require 'spec_helper'

describe Package do
  it { should belong_to :sender }
  it { should have_many :recipients }
  it { should have_many :attachments }

  it { should validate_presence_of :message }
end
