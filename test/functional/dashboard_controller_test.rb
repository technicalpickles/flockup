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
    should_have_search_form
    should_display_tabs
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
