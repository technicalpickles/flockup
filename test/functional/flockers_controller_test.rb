require File.dirname(__FILE__) + '/../test_helper'

class FlockersControllerTest < ActionController::TestCase

  def setup
    @flocker = Factory(:flocker)
  end

  should_be_restful do |resource|
    resource.formats = [:html, :xml]
    resource.destroy.flash = nil
  end
end
