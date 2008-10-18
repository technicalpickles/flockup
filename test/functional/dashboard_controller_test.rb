require File.dirname(__FILE__) + '/../test_helper'

class DashboardControllerTest < ActionController::TestCase
  def setup
  end
  
  context "viewing homepage" do
    should_route :get, '/', :controller => :dashboard, :action => :index
  end

  context "viewing dashboard" do
    setup do
      assert_nothing_raised { get :index }
    end
  
    should_respond_with :success
    should_render_template :index
  end
      
end