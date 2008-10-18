require File.dirname(__FILE__) + '/../test_helper'

class FlockTest < ActiveSupport::TestCase
  
  def setup
    @flock = Factory(:flock)
  end
  
  should_require_attributes :name
  should_ensure_length_in_range :name, (2..20)
  should_require_unique_attributes :name
  
  should_not_allow_values_for :name, "asdfa ", "asdf!", "zxzi*", "2zxv()"
  should_allow_values_for :name, "ruby", "rails", "boston.rb", "oh_hai", "1--"
  
  should_have_index :name
end
