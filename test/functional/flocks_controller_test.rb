require File.dirname(__FILE__) + '/../test_helper'

class FlocksControllerTest < ActionController::TestCase
  def setup
    @flock = Factory(:flock)
    @flocks = [@flock]
  end
  
  context "viewing flock index" do
    setup do
      assert_nothing_raised { get :index }
    end
  
    should_respond_with :success
    should_render_template :index
    
    should_link_to 'new_flock_path'
    
    should_link_to 'flock_path(@flock)'
  end
  
  context "viewing new flock form" do
    setup do
      assert_nothing_raised { get :new }
    end
    
    should_respond_with :success
    should_render_template :new
    
    should 'have a form, with fields for name, and description, and submit' do
      assert_select "form[action=#{flocks_path}]" do
        assert_select "input[name='flock[name]']"
        assert_select "textarea[name='flock[description]']"
        assert_select "input[type=submit]"
      end
    end
  end
end