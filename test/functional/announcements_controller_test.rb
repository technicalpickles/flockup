require File.dirname(__FILE__) + '/../test_helper'

class AnnouncementsControllerTest < ActionController::TestCase
  context 'GET to index' do
    setup do
      get :index
    end
    should_respond_with :success
    should_assign_to :announcements
  end

  context 'GET to new' do
    setup do
      get :new
    end

    should_respond_with :success
    should_render_template :new
    should_assign_to :announcement
  end

  context 'POST to create' do
    setup do
      post :create, :announcement => Factory.attributes_for(:announcement)
      @announcement = Announcement.find(:all).last
    end
    
    should_redirect_to 'announcement_path(@announcement)'
  end

  context 'GET to show' do
    setup do
      @announcement = Factory(:announcement)
      get :show, :id => @announcement.id
    end
    should_respond_with :success
    should_render_template :show
    should_assign_to :announcement
  end

  context 'GET to edit' do
    setup do
      @announcement = Factory(:announcement)
      get :edit, :id => @announcement.id
    end
    should_respond_with :success
    should_render_template :edit
    should_assign_to :announcement
  end

  context 'PUT to update' do
    setup do
      @announcement = Factory(:announcement)
      put :update, :id => @announcement.id, :announcement => Factory.attributes_for(:announcement)
    end
    should_redirect_to 'announcement_path(@announcement)'
  end

  context 'DELETE to destroy' do
    setup do
      @announcement = Factory(:announcement)
      delete :destroy, :id => @announcement.id
    end
    should_redirect_to 'announcements_path'
  end
end
