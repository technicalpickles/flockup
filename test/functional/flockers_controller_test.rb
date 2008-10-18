require File.dirname(__FILE__) + '/../test_helper'

class FlockersControllerTest < ActionController::TestCase
  
  def setup
    @flocker = Factory(:flocker)
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
end
