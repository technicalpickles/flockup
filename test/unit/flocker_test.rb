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
  
  context "a new flocker with valid twitter_username" do
    setup do
      @flocker = Factory.build(:flocker, :twitter_username => 'whattheflock')
    end

    should "be unverified" do
      assert @flocker.unverified?
    end
    
    context "after marking as verified" do
      setup do
        @flocker.verify!
      end

      should "now be verified" do
        deny @flocker.unverified?, "flocker was unverified, but should have been verified"
      end
    end
  end
end
