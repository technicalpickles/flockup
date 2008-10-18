class Flocker < ActiveRecord::Base
  has_and_belongs_to_many :flocks
  validates_uniqueness_of :twitter_username
end
