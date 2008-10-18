class DashboardController < ApplicationController

  def index
  end
  
  def search
    matching_flocks = Flock.find(:all, :conditions => ['name = ?', params[:search]])
    if matching_flocks.size == 1
      redirect_to :controller => 'flocks', :action => 'show', :id => matching_flocks.first
    end
    flash.now[:notice] = 'No results.'
  end

end
