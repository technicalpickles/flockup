class Announcement < ActiveRecord::Base
  validates_presence_of :message, :starts_at, :ends_at

  has_markup :message

  def self.current(hide_time = nil)
    with_scope :find => {:conditions => 'starts_at <= now() AND ends_at >= now()'} do
      if hide_time
        find(:all, :conditions => ['starts_at >= ?', hide_time])
      else
        find(:all)
      end
    end
  end
end
