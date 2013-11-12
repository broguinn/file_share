require 'spec_helper'

describe Attachment do
  it { should belong_to :package }

  it { should validate_presence_of :file_name }
  it { should validate_presence_of :file_type }
end
