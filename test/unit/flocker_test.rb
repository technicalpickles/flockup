require File.dirname(__FILE__) + '/../test_helper'

class FlockerTest < ActiveSupport::TestCase
  def setup
    @flocker = Factory(:flocker)
  end
  
  should_have_db_column :twitter_username
  should_have_and_belong_to_many :flocks
  should_require_unique_attributes :twitter_username
end
