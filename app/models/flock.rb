class Flock < ActiveRecord::Base
  validates_presence_of :name
  validates_length_of :name, :within => 2..20
  validates_uniqueness_of :name
  validates_format_of :name, :with => /^[a-z\d_]+$/
  
  has_and_belongs_to_many :flockers
  
  attr_accessible :name, :description
  
  has_friendly_id :name
  
  cattr_accessor :per_row
  @@per_row = 5
  cattr_accessor :per_page
  @@per_page = @@per_row*7
end
