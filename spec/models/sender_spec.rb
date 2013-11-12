require 'spec_helper'

describe Sender do
  it { should have_many :packages }

  it { should validate_presence_of :email}
  it { should validate_presence_of :name }
end
