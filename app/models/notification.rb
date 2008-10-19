class Notification < ActiveRecord::Base
  belongs_to :flocker
  belongs_to :flock
  
  def twitter_username
    flocker.twitter_username
  end
  
  def notifiy
    notify_on_twitter("you've been removed from the #{self.name} flock #{APP_URL}/flocks/#{self.id}")
  end
end
