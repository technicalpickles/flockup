class AnnouncementsController < ApplicationController
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
end
