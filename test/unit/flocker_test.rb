require File.dirname(__FILE__) + '/../test_helper'

class FlockerTest < ActiveSupport::TestCase
    
  should_have_db_column :twitter_username
  should_have_and_belong_to_many :flocks
  
  context "An existing flock" do
    setup do
      @flocker = Factory(:flocker)
    end

    should_require_unique_attributes :twitter_username
  end
  
  context "a new flock" do
    setup do
      @flock = Factory.build(:flocker, :twitter_username => 'techpickles')
    end

    should "be unverified" do
      assert @flock.unverified?
    end
  end
end
