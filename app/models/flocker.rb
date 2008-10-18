require 'twitter'

class Flocker < ActiveRecord::Base
  include TwitterVerifier
  
  has_and_belongs_to_many :flocks
  validates_uniqueness_of :twitter_username
  
  def unverified?
    self[:status] != 'verified'
  end
  
  def verify!
    if valid_username?(self.twitter_username)
      self.update_attributes(:status => 'verified')
    else
      self.update_attributes(:status => 'unverified')
    end
  end
end
