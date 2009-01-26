# FIXME I don't think this class actually is used anymore. Also, no tests.
class Notification < ActiveRecord::Base
  belongs_to :flocker
  belongs_to :flock
  
  def twitter_username
    flocker.twitter_username
  end
end
