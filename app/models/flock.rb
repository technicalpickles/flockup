class Flock < ActiveRecord::Base
  validates_presence_of :name
  validates_length_of :name, :within => 2..20
  validates_uniqueness_of :name
  validates_format_of :name, :with => /^[a-z\d_]+$/
  
  has_and_belongs_to_many :flockers, :after_add => :notify_added, :after_remove => :notify_removed
  
  attr_accessible :name, :description
  
  has_friendly_id :name
  
  cattr_accessor :per_row
  @@per_row = 5
  cattr_accessor :per_page
  @@per_page = @@per_row*7
  
  def notify_added(flocker)
    unless flocker.twitter_username.blank? || !flocker.verified_twitter_username?
      @notice = Notification.create(:flocker => flocker, :text => "hey, someone added you to flockup.com. check it out! #{APP_URL}/flockers/#{self.id}")
      @notice.push('notify_flocker')
    end
  end
  
  def notify_removed(flocker)
    unless flocker.twitter_username.blank? || !flocker.verified_twitter_username?
      @notice = Notification.create(:flocker => flock, :text => "you've been added to the #{flock.name} flock #{APP_URL}/flocks/#{flock.id}")
      @notice.push('notify_flocker')
    end
  end
  
end
