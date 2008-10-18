class Flock < ActiveRecord::Base
  validates_presence_of :name
  validates_length_of :name, :within => 2..20
  validates_uniqueness_of :name
  validates_format_of :name, :with => /^[a-z\d]+$/
end
