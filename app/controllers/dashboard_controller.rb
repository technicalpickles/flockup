class DashboardController < ApplicationController

  def index
  end
  
  def search
    @results = Flock.find(:all, :conditions => ['name = ?', params[:search]])
    if @results.size == 1
      redirect_to :controller => 'flocks', :action => 'show', :id => @results.first
    end
    if @results.empty?
      @results = Flocker.find(:all, :conditions => ['twitter_username = ?', params[:search]])
      if @results.size == 1
        redirect_to :controller => 'flockers', :action => 'show', :id => @results.first
      end
    end
  end

end
