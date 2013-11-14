require 'spec_helper'
require 'rake'

describe 'clean rake task' do
  before do
    Rake.application.rake_require "tasks/clean"
    Rake::Task.define_task(:environment)
    @package = FactoryGirl.create(:package)
  end

  it 'should remove all packages made over 72 hours ago' do
    @package.update(created_at: 1.week.ago)
    Rake::Task["clean"].reenable
    Rake::Task["clean"].invoke
    Package.all.count.should be 0
  end

  it 'should not remove packages made within 72 hours' do
    Rake::Task["clean"].reenable
    Rake::Task["clean"].invoke
    Package.all.count.should be 1
  end
end
