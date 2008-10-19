require File.dirname(__FILE__) + '/../test_helper'

class PagesControllerTest < ActionController::TestCase
  def setup
  end
  
  context "viewing about" do
    setup do
      assert_nothing_raised { get :about }
    end
    should_respond_with :success
    should_render_template :about
  end

  context "viewing terms of service" do
    setup do
      assert_nothing_raised { get :terms_of_service }
    end
    should_respond_with :success
    should_render_template :terms_of_service
  end

  context "viewing contact" do
    setup do
      assert_nothing_raised { get :contact }
    end
    should_respond_with :success
    should_render_template :contact
  end

end
