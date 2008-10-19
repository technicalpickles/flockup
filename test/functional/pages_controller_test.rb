require File.dirname(__FILE__) + '/../test_helper'

class PagesControllerTest < ActionController::TestCase
  context "viewing about" do
    setup do
      assert_nothing_raised { get :about }
    end
    should_respond_with :success
    should_render_template :about
  end
end
