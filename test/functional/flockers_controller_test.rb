require File.dirname(__FILE__) + '/../test_helper'

class FlockersControllerTest < ActionController::TestCase
  
  def setup
    @flocker = Factory(:flocker)
    @flockers = [@flocker]
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
  
  
end
