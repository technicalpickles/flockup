require 'twitter'

class Flocker < ActiveRecord::Base
  include TwitterVerifier
  
  has_and_belongs_to_many :flocks
  validates_uniqueness_of :twitter_username
  
  after_create :queue_for_verification
  
  def unverified?
    self[:status] != 'verified'
  end
  
  def verify_twitter_username
    if valid_username?(self.twitter_username)
      self.update_attributes(:status => 'verified')
    else
      self.update_attributes(:status => 'unverified')
    end
  end
  
protected
  def queue_for_verification
    push('verify_twitter_username')
    # FlockerWorker.async_verify(:id => self.id)
  end
end
