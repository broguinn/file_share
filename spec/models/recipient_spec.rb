require 'spec_helper'

describe Recipient do
  it { should belong_to :package }

  it { should validate_presence_of :email }
end
