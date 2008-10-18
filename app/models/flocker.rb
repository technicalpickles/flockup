require 'twitter'

class Flocker < ActiveRecord::Base
  has_and_belongs_to_many :flocks
  validates_uniqueness_of :twitter_username
  
  def unverified?
    self[:status] != 'verified'
  end
  
  def verify!
    twitter_user = lookup_twitter_user
    if twitter_user
      self.update_attributes(:status => 'verified')
    else
      self.update_attributes(:status => 'unverified')
    end
  end
  
protected
  def lookup_twitter_user
    begin
      twitter.user(self.twitter_username)
    rescue Twitter::CantConnect => e
      if e.message =~ /404/
        nil
      else
        raise
      end
    end
  end
  
  def twitter
    @twitter ||= Twitter::Base.new('flockup', 'v4mp1r3')
  end
end
