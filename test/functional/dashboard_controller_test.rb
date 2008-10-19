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
      assert_select ".result_count", /0\s+results./
    end
  end
      
  context "searching for a flock and finding one" do
    setup do
      Factory(:flock, :name => 'dontfindme')
      Factory(:flock, :name => 'meneither')
      Factory(:flocker, :twitter_username => 'dontfindme')
      Factory(:flocker, :twitter_username => 'meneither')
      @target_flock = Factory(:flock, :name => 'searchtest')
      get :search, :search => 'searchtest'
    end

    should_respond_with :redirect
    should_redirect_to "flock_url(@target_flock)"
  end
      
  context "searching for a flocker and finding one" do
    setup do
      Factory(:flock, :name => 'dontfindme')
      Factory(:flock, :name => 'meneither')
      Factory(:flocker, :twitter_username => 'dontfindme')
      Factory(:flocker, :twitter_username => 'meneither')
      @target_flocker = Factory(:flocker, :twitter_username => 'ohhaithere')
      get :search, :search => 'ohhaithere'
    end

    should_respond_with :redirect
    should_redirect_to "flocker_url(@target_flocker)"
  end
  
  context "searching for a term with 2 flocks results" do
    setup do
      @ruby_flock = Factory(:flock, :name => 'ruby')
      @rubyonrails_flock = Factory(:flock, :name => 'rubyonrails')
      
      get :search, :search => 'ruby'
    end

    should_respond_with :success
    should_render_template :search
    
    should_link_to 'flock_path(@ruby_flock)'
    should_link_to 'flock_path(@rubyonrails_flock)'
  end
  
  context "searching for a term with 2 flocker results" do
    setup do
      @techpickles_flocker = Factory(:flocker, :twitter_username => 'techpickles')
      @pickles_flocker = Factory(:flocker, :twitter_username => 'pickles')
      get :search, :search => 'pickles'
    end

    should_respond_with :success
    should_render_template :search
    
    should_link_to 'flocker_path(@techpickles_flocker)'
    should_link_to 'flocker_path(@pickles_flocker)'
  end
  
  # context "search for a term with mixed results" do
  #   setup do
  #     @ruby_flock = Factory(:flock, :name => 'ruby')
  #     @rubyist_flocker = Factory(:flocker, :twitter_username => 'flocker')
  #     get :search, :search => 'ruby'
  #   end
  #   
  #   should_respond_with :success
  #   should_render_template :search
  #   
  #   should_link_to 'flock_path(@ruby_flock)'
  #   should_link_to 'flocker_path(@rubyist_flocker)'
  # end
  
  
  
      
end
