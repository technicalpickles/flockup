class Flocker < ActiveRecord::Base
  has_and_belongs_to_many :flocks
end
