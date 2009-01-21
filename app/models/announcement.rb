class Announcement < ActiveRecord::Base
  validates_presence_of :message, :starts_at, :ends_at
end
