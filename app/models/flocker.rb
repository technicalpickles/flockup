require 'twitter'

class Flocker < ActiveRecord::Base
  include TwitterVerifier
  include TwitterNotifier
  
  VERIFIED = 'verified'
  INVALID = 'invalid'
  UNVERIFIED = 'unverified'
  
  has_and_belongs_to_many :flocks
  validates_uniqueness_of :twitter_username
  validates_presence_of :twitter_username
  validates_length_of :twitter_username, :within => 1..15
  validates_format_of :twitter_username, :with => /^[a-z\d_]+$/
  validates_inclusion_of :status, :in => [UNVERIFIED, INVALID, VERIFIED], :message => 'is not included in the list'
  
  after_create :queue_for_verification
  before_validation_on_create :set_unverified, :unless => :status?
  
  named_scope :unverified, :conditions => ['status = ?', UNVERIFIED]
  named_scope :verified, :conditions => ['status = ?', VERIFIED]
  named_scope :invalid, :conditions => ['status = ?', INVALID]
  named_scope :not_invalid, :conditions => ['status != ?', INVALID]
  
  attr_accessible :twitter_username
  
  has_friendly_id :twitter_username
  
  cattr_accessor :per_row
  @@per_row = 5
  cattr_accessor :per_page
  @@per_page = @@per_row*7

  
  def unverified_twitter_username?
    self[:status].blank? || self[:status] == UNVERIFIED
  end
  
  def verified_twitter_username?
    self[:status] == VERIFIED
  end
  
  def invalid_twitter_username?
    self[:status] == INVALID
  end
  
  def verify_twitter_username
    if valid_username?()
      self.status = VERIFIED
      self.save!
      push('notify_about_flockup')
    else
      self.status = INVALID
      self.save!
    end
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
