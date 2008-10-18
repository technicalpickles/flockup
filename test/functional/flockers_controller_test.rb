require File.dirname(__FILE__) + '/../test_helper'

class FlockersControllerTest < ActionController::TestCase
  
  def setup
    @flocker = Factory(:flocker, :twitter_username => 'flockup', :flocks => [Factory(:flock)])
    assert_equal 1, @flocker.flocks.count

    @flockers = [@flocker]
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
    
    should_link_to 'new_flocker_path'
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
        post :create, :flock_id => @flock.to_param, :flocker => {:twitter_username => @flocker.twitter_username}
      end
    end

    should_respond_with :redirect
    should_redirect_to "flock_url(@flock)"
    
    should_not_change "Flocker.count"
    should_change "@flock.flockers.count", :by => 1
    
    should_set_the_flash_to /adding to/i
  end
  
  context "submitting an existing flocker to a flock they are already in" do
    setup do
      assert_nothing_raised do
        post :create, :flock_id => @flocker.flocks.first.to_param, :flocker => {:twitter_username => @flocker.twitter_username}
      end
    end
    
    should_respond_with :redirect
    should_redirect_to "flock_url(@flock)"
    
    should_not_change "Flocker.count"
    should_not_change "@flock.flockers.count"
    
    should_set_the_flash_to /already in/i
  end
  
  context "viewing a flocker" do
    setup do
      assert_nothing_raised do
        get :show, :id => @flocker.to_param
      end
    end

    should_respond_with :success
    
    should "link to each of their flocks" do
      @flocker.flocks.each do |flock|
        assert_select "a[href=#{flock_path(flock)}]"
      end
    end

    should_not_link_to 'edit_flocker_path(@flocker)'
    should_link_to '"http://twitter.com/#{@flocker.twitter_username}"'
  end
  
  
  
end
