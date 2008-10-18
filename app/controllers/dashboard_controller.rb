class DashboardController < ApplicationController

  def index
  end
  
  def search
    flash.now[:notice] = 'No results.'
  end

end
