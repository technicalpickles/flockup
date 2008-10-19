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
    should_link_to 'new_flock_path'
    should_display_tabs
  end

  context "searching" do
    setup do
      get :search, :search => 'something'
    end

    should_respond_with :success
    should_render_template :search
    should 'have a search form' do
      assert_select "form[action=#{dashboard_search_path}]" do
        assert_select "input[name='search']"
        assert_select "input[type=submit]"
      end
    end
  end

  context "searching for a flock or flocker that isn't there" do
    setup do
      Factory(:flock, :name => 'dontfindme')
      Factory(:flocker, :twitter_username => 'dontfindme')
      Factory(:flock, :name => 'dontfindme2')
      Factory(:flocker, :twitter_username => 'dontfindme2')
      get :search, :search => 'nonexistant'
    end

    should_respond_with :success
    should "display no results found" do
      assert_select "div#search_results", /0\s+results./
    end
  end
      
  context "searching for a flock and finding one" do
    setup do
      Factory(:flock, :name => 'dontfindme')
      Factory(:flock, :name => 'dontfindmeeither')
      Factory(:flocker, :twitter_username => 'dontfindme')
      Factory(:flocker, :twitter_username => 'dontfindmeeither')
      @target_flock = Factory(:flock, :name => 'searchtest')
      get :search, :search => 'searchtest'
    end

    should_respond_with :redirect
    should_redirect_to "flock_url(@target_flock)"
  end
      
  context "searching for a flocker and finding one" do
    setup do
      Factory(:flock, :name => 'dontfindme')
      Factory(:flock, :name => 'dontfindmeeither')
      Factory(:flocker, :twitter_username => 'dontfindme')
      Factory(:flocker, :twitter_username => 'dontfindmeeither')
      @target_flocker = Factory(:flocker, :twitter_username => 'loveinallthewrongplaces')
      get :search, :search => 'loveinallthewrongplaces'
    end

    should_respond_with :redirect
    should_redirect_to "flocker_url(@target_flocker)"
  end
      
end
