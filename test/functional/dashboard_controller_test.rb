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
    should 'have a search form' do
      assert_select "form[action=#{dashboard_search_path}]" do
        assert_select "input[name='search']"
        assert_select "input[type=submit]"
      end
    end
  end
      
end