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

  context "searching" do
    setup do
      get :search, :search => 'something'
    end

    should_respond_with :success
    should_render_template :search
  end

  context "searching for something that isn't there" do
    setup do
      get :search, :search => 'nonexistant user'
    end

    should_respond_with :success
    should_set_the_flash_to /no results/i
  end
      
  context "searching for a flock" do
    setup do
      Factory(:flock, :name => 'dontfindme')
      @target_flock = Factory(:flock, :name => 'searchtest')
      Factory(:flock, :name => 'dontfindmeeither')
      get :search, :search => 'searchtest'
    end

    should_respond_with :redirect
    should_redirect_to "flock_url(@target_flock)"
  end
      
end
