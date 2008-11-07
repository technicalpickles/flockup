require File.dirname(__FILE__) + '/../test_helper'

class FlockersControllerTest < ActionController::TestCase
  
  def setup
    @flocker1 = Factory(:flocker, :twitter_username => 'aaaaa', :flocks => [Factory(:flock)])
    @flocker2 = Factory(:flocker, :twitter_username => 'bbbbb', :flocks => [Factory(:flock)])
    assert_equal 1, @flocker1.flocks.count

    @flockers = [@flocker1, @flocker2]
    @flock = Factory(:flock)
  end
  
  context "viewing the flockers list" do
    setup do
      assert_nothing_raised do
        get :index
      end
    end
    
    should_respond_with :success
    should_render_template :index
    should_assign_to :flockers, :equals => '@flockers'
    
    should_link_to 'new_flocker_path', 2

    should_display_tabs
    should_have_current_tab 'Flockers'
  end
  
  context "view form to create flocker" do
    setup do
      assert_nothing_raised do
        get :new
      end
    end

    should_respond_with :success
    should_render_template :new
    
    should_assign_to :flocker
  end
  
  context "submitting a brand new flocker to a flock" do
    setup do
      assert_nothing_raised do
        post :create, :flock_id => @flock.to_param, :flocker => {:twitter_username => 'pickles'}
      end
    end

    should_respond_with :redirect
    should_redirect_to "flock_url(@flock)"
    
    should_change "Flocker.count", :by => 1
    should_change "@flock.flockers.count", :by => 1
  end
  
  context "submitting an existing flocker to a new flock" do
    setup do
      assert_nothing_raised do
        post :create, :flock_id => @flock.to_param, :flocker => {:twitter_username => @flocker1.twitter_username}
      end
    end

    should_respond_with :redirect
    should_redirect_to "flock_url(@flock)"
    
    should_not_change "Flocker.count"
    should_change "@flock.flockers.count", :by => 1
  end
  
  context "submitting an existing flocker to a flock they are already in" do
    setup do
      assert_nothing_raised do
        post :create, :flock_id => @flocker1.flocks.first.to_param, :flocker => {:twitter_username => @flocker1.twitter_username}
      end
    end
    
    should_respond_with :redirect
    should_redirect_to "flock_url(@flock)"
    
    should_not_change "Flocker.count"
    should_not_change "@flock.flockers.count"
  end
  
  context "viewing a flocker by twitter username" do
    setup do
      assert_nothing_raised do
        get :show, :id => @flocker1.twitter_username
      end
    end

    should_respond_with :success
    
    should "link to each of their flocks" do
      @flocker1.flocks.each do |flock|
        assert_select "a[href=#{flock_path(flock)}]"
      end
    end

    should_not_link_to 'edit_flocker_path(@flocker1)'
    should_link_to '"http://twitter.com/#{@flocker1.twitter_username}"', 1
    
    should_eventually "have form to add them to a flock" do
      
    end
  end
  
  context "viewing a flocker by id" do
    setup do
      assert_nothing_raised do
        get :show, :id => @flocker1.id
      end
    end

    should_redirect_to "flocker_url(@flocker1)"
  end
  
end
