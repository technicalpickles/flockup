require File.dirname(__FILE__) + '/../test_helper'

class FlockerTest < ActiveSupport::TestCase
  should_have_db_column :twitter_username
  should_have_and_belong_to_many :flocks
end
