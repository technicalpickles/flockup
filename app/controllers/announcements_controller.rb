class AnnouncementsController < ApplicationController
  USER_NAME, PASSWORD = "admin", "v4mp1r3"

  before_filter :authenticate, :except => [ :index, :show, :hide ]
  
  def index
    @announcements = Announcement.find(:all)

    respond_to do |format|
      format.html
    end
  end

  def show
    @announcement = Announcement.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @announcement = Announcement.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @announcement = Announcement.find(params[:id])
  end

  def create
    @announcement = Announcement.new(params[:announcement])

    respond_to do |format|
      if @announcement.save
        flash[:notice] = 'Announcement was successfully created.'
        format.html { redirect_to(@announcement) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @announcement = Announcement.find(params[:id])

    respond_to do |format|
      if @announcement.update_attributes(params[:announcement])
        flash[:notice] = 'Announcement was successfully updated.'
        format.html { redirect_to(@announcement) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @announcement = Announcement.find(params[:id])
    @announcement.destroy

    respond_to do |format|
      format.html { redirect_to(announcements_url) }
    end
  end

  def hide
    session[:announcement_hide_time] = Time.now

    respond_to do |format|
      format.json { render :json => {:success => true} }
    end
  end

  private

  def authenticate
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == USER_NAME && password == PASSWORD
    end
  end
end
