class DashboardController < ApplicationController

  def index
  end
  
  def search
    @search_terms = params[:search]

    unless @search_terms.blank?
      @search_terms = @search_terms.downcase
      # gah, should be in a model somewhere
      @results = Flock.find(:all, :conditions => ['name LIKE ?', "%#{@search_terms}%"]) + Flocker.find(:all, :conditions => ['twitter_username LIKE ?', "%#{@search_terms}%"])
      if @results.size == 1
        redirect_to @results.first
      end
    end
  end

end
