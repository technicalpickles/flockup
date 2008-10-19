require 'twitter'

class Flocker < ActiveRecord::Base
  include TwitterVerifier
  include TwitterNotifier
  
  VERIFIED = 'verified'
  INVALID = 'invalid'
  UNVERIFIED = 'unverified'
  
  has_and_belongs_to_many :flocks
  validates_uniqueness_of :twitter_username
  
  after_create :queue_for_verification
  before_validation_on_create :set_unverified
  
  named_scope :unverified, :conditions => ['status = ?', UNVERIFIED]
  named_scope :verified, :conditions => ['status = ?', VERIFIED]
  named_scope :invalid, :conditions => ['status = ?', INVALID]
  named_scope :not_invalid, :conditions => ['status != ?', INVALID]

  
  def unverified_twitter_username?
    self[:status].blank? 
  end
  
  def verified_twitter_username?
    self[:status] == VERIFIED
  end
  
  def invalid_twitter_username?
    self[:status] == INVALID
  end
  
  def verify_twitter_username
    if valid_username?()
      self.update_attributes(:status => 'verified')
      push('notify_about_flockup')
    else
      self.update_attributes(:status => 'invalid')
    end
  end
  
  def notify_about_flockup
    notify_on_twitter "hey, someone tagged you on flockup. check it out! http://twitterflocks.r08.railsrumble.com/flockers/#{self.to_param}"
  end
protected
  def set_unverified
    self[:status] = UNVERIFIED
  end
  
  def queue_for_verification
    push('verify_twitter_username')
    # FlockerWorker.async_verify(:id => self.id)
  end
end
