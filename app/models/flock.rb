class Flock < ActiveRecord::Base
  validates_presence_of :name
  validates_length_of :name, :within => 2..20
  validates_uniqueness_of :name
  validates_format_of :name, :with => /^[a-z\d_]+$/
  
  has_and_belongs_to_many :flockers, :after_add => :notify_added, :after_remove => :notify_removed
  
  attr_accessible :name, :description
  
  def notify_added(flocker)
    unless flocker.twitter_username.blank?
      flocker.notify_on_twitter("you've been added to the #{self.name} flock #{APP_URL}/flocks/#{self.name}")
    end
  end
  
  def notify_removed(flocker)
    unless flocker.twitter_username.blank?
      flocker.notify_on_twitter("you've been removed from the #{self.name} flock #{APP_URL}/flocks/#{self.name}")
    end
  end
end
