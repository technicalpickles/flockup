require File.dirname(__FILE__) + '/../test_helper'

class FlocksControllerTest < ActionController::TestCase
  def setup
    @flock = Factory(:flock, :flockers => (1..2).collect { Factory(:flocker) })
    assert_equal 2, @flock.flockers.count
    
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
  
  context "submitting the flock form successfully" do
    setup do
      assert_nothing_raised {
        post :create, :flock => {:name => 'awesome', :description => 'nothing is awesomer than the a team'}
      }
    end

    should_respond_with :redirect
    should_redirect_to "flock_path(@flock)"
    
    should_set_the_flash_to /success/i
    should_change "Flock.count", :by => 1
  end
  
  context "viewing a flock" do
    setup do
      assert_nothing_raised { get :show, :id => @flock }
    end

    should_respond_with :success
    should_render_template :show
    
    should_eventually "display the name"
    should_eventually "display the description"
    
    should "display a link to view each flocker" do
      @flock.flockers.each do |flocker|
        assert_select "a[href=#{flocker_path(flocker)}]"
      end
    end
    
    should_eventually "display a link to remove each flocker"
    should "display a form to add a new flocker to the flock" do
      assert_select "form[action=#{flock_flockers_path(@flock)}]" do
        assert_select "input[name='flocker[twitter_username]']"
        assert_select "input[type=submit]"
      end
    end
  end
  
  
end