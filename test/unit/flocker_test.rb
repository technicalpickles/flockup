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
      @flocker = Factory.build(:flocker, :twitter_username => 'flockup')
      @flocker.stubs(:valid_username?).with().returns(true)
    end

    should "be unverified" do
      assert @flocker.unverified?
    end
    
    context "after marking attempting verification" do
      setup do
        @flocker.verify_twitter_username
      end

      should "now be verified" do
        deny @flocker.unverified?, "flocker was unverified, but should have been verified"
      end
    end
  end
  
  context "description" do
    setup do
      @flocker = Factory.build(:flocker, :twitter_username => 'flockup')
      @flocker.stubs(:valid_username?).with().returns(false)
    end

    should "be unverified" do
      assert @flocker.unverified?
    end
    
    context "after marking as verified" do
      setup do
        @flocker.verify_twitter_username
      end

      should "still be unverified" do
        assert @flocker.unverified?, "flocker was verified, but should have been unverified"
      end
    end
  end
  
end
