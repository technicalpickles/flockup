require File.dirname(__FILE__) + '/../../test_helper'

class FlockerWorkerTest < ActiveSupport::TestCase
  def setup
    @flocker = Factory(:flocker)
  end
  
  # context "verifying a flocker with valid twitter username" do
  #   setup do
  #     @flocker.stubs(:valid_username?).with(@flocker.twitter_username).returns(true)
  #     
  #     @flocker_worker = FlockerWorker.new
  #     @flocker_worker.verify(:id => @flocker.to_param)
  #     
  #     @flocker.reload
  #   end
  # 
  #   should_change "@flocker.unverified?", :to => false
  # end
  
end