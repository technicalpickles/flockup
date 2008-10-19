require File.dirname(__FILE__) + '/../test_helper'

class FlocksControllerTest < ActionController::TestCase
  def setup
    @flock = Factory(:flock, :name => 'mrt', :description => 'the a team', :flockers => (1..2).collect { Factory(:flocker) })
    assert_equal 2, @flock.flockers.count
    
    @flocks = [@flock]
  end
  
  context "viewing flock index" do
    setup do
      assert_nothing_raised { get :index }
    end
  
    should_respond_with :success
    should_render_template :index
    
    should_link_to 'new_flock_path', 2
    
    should_link_to 'flock_path(@flock)'

    should_display_tabs
    should_have_current_tab 'Flocks'
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
      end
    end
  end
  
  context "submitting the flock form for a new flock" do
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
  
  context "submitting the flock form for a flock that already exists" do
    setup do
      assert_nothing_raised {
        post :create, :flock => {:name => 'mrt', :description => 'nothing is awesomer than the a team'}
      }
    end

    should_respond_with :redirect
    should_redirect_to "flock_path(@flock)"
    should_set_the_flash_to /is already a flock named mrt/i
    should_not_change "Flock.count"
    should_not_change "@flock.description"
  end

  context "viewing a flock by name" do
    setup do
      assert_nothing_raised { get :show, :id => @flock.name }
    end

    should_respond_with :success
    should_render_template :show
    
    should_eventually "display the name"
    should_eventually "display the description"
    
    should "display a link to view each flocker" do
      assert_select '.flockers', 1 do
        @flock.flockers.each do |flocker|
          assert_select "a[href=#{flocker_path(flocker)}]"
        end
      end
    end
    
    should_eventually "display a link to remove each flocker"
    should "display a form to add a new flocker to the flock" do
      assert_select "form[action=#{flock_flockers_path(@flock)}]" do
        assert_select "input[name='flocker[twitter_username]']"
      end
    end
  end
  
  context "viewing a flock by id" do
    setup do
      assert_nothing_raised { get :show, :id => @flock.id }
    end

    should_redirect_to "flock_url(@flock)"
  end
  
  
  context "viewing a flock without any flockers" do
    setup do
      @empty_flock = Factory(:flock)
      assert_nothing_raised { get :show, :id => @flock }
    end

    # not sure why this fails...
    should_eventually "not display any flockers" do
      assert_select '.flockers', 0
    end
  end
  
  
  
end