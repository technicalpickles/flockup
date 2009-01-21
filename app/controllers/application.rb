class ApplicationController < ActionController::Base
  include HoptoadNotifier::Catcher
  
  helper :all # include all helpers, all the time

  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '7684b2288928eae7b89dd9f88defaae9'
  
  filter_parameter_logging :password

  helper_method :current_announcements

  def current_announcements
    @current_announcements ||= Announcement.current(session[:announcement_hide_time])
  end
end
