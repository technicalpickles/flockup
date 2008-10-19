require 'twitter'

class Flocker < ActiveRecord::Base
  include TwitterVerifier
  include TwitterNotifier
  
  has_and_belongs_to_many :flocks
  validates_uniqueness_of :twitter_username
  
  after_create :queue_for_verification
  
  def unverified?
    self[:status] != 'verified'
  end
  
  def verify_twitter_username
    if valid_username?()
      self.update_attributes(:status => 'verified')
      push('notify_about_flockup')
    else
      self.update_attributes(:status => 'unverified')
    end
  end
  
  def notify_about_flockup
    notify_on_twitter "hey, someone tagged you on flockup. check it out! http://twitterflocks.r08.railsrumble.com/flockers/#{self.to_param}"
  end
protected
  def queue_for_verification
    push('verify_twitter_username')
    # FlockerWorker.async_verify(:id => self.id)
  end
end
