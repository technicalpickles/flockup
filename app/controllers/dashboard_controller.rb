class DashboardController < ApplicationController

  def index
  end
  
  def search
    @results = Flock.find(:all, :conditions => ['name LIKE ?', "%#{params[:search].downcase}%"]) + Flocker.find(:all, :conditions => ['twitter_username LIKE ?', "%#{params[:search].downcase}%"])
    if @results.size == 1
      redirect_to @results.first
    end
  end

end
