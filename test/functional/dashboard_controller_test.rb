require File.dirname(__FILE__) + '/../test_helper'

class DashboardControllerTest < ActionController::TestCase
  def setup
  end
  
  context "viewing index" do
    should_route :get, '/', :controller => :dashboard, :action => :index
  end

  
end