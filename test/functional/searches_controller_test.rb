require File.dirname(__FILE__) + '/../test_helper'

class SearchesControllerTest < ActionController::TestCase
  context "viewing results for a page" do
    setup do
      get :index, :q => 'something'
    end

    should_respond_with :success
    should_render_template :index
    should_have_search_form
  end
  
  context "viewing form to perform search" do
    setup do
      get :new
    end

    should_respond_with :success
    should_render_template :new
    should_have_search_form
  end
  

  context "searching for a flock or flocker that isn't there" do
    setup do
      Factory(:flock, :name => 'dontfindme')
      Factory(:flocker, :twitter_username => 'dontfindme')
      Factory(:flock, :name => 'dontfindme2')
      Factory(:flocker, :twitter_username => 'dontfindme2')
      get :index, :q => 'nonexistant'
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
      get :index, :q => 'searchtest'
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
      get :index, :q => 'ohhaithere'
    end

    should_respond_with :redirect
    should_redirect_to "flocker_url(@target_flocker)"
  end
  
  context "searching for a term with 2 flocks results" do
    setup do
      @ruby_flock = Factory(:flock, :name => 'ruby')
      @rubyonrails_flock = Factory(:flock, :name => 'rubyonrails')
      
      get :index, :q => 'ruby'
    end

    should_respond_with :success
    should_render_template :index
    
    should_link_to 'flock_path(@ruby_flock)'
    should_link_to 'flock_path(@rubyonrails_flock)'
  end
  
  context "searching for a term with 2 flocker results" do
    setup do
      @techpickles_flocker = Factory(:flocker, :twitter_username => 'techpickles')
      @pickles_flocker = Factory(:flocker, :twitter_username => 'pickles')
      get :index, :q => 'pickles'
    end

    should_respond_with :success
    should_render_template :index
    
    should_link_to 'flocker_path(@techpickles_flocker)'
    should_link_to 'flocker_path(@pickles_flocker)'
  end

  context "searching for a term which includes a period" do
    setup do
      get :index, :q => 'ruby.com'
    end
    should_respond_with :success
    should_render_template :index
  end
end
