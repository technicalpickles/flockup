require File.dirname(__FILE__) + '/../test_helper'

class AnnouncementTest < ActiveSupport::TestCase
  should_require_attributes :message, :starts_at, :ends_at

  context "some announcements" do
    setup do
      @old_announcement = Factory(:announcement, :starts_at => 2.months.ago, :ends_at => 1.month.ago)
      @current_announcement = Factory(:announcement, :starts_at => 2.weeks.ago, :ends_at => 2.weeks.from_now)
      @future_announcement = Factory(:announcement, :starts_at => 2.weeks.from_now, :ends_at => 1.month.from_now)
    end

    context "Annoucement.current without hide time" do
      setup do
        @announcements = Announcement.current
      end

      should "return only the current announcement" do
        assert_equal 1, @announcements.size
        assert_equal @current_announcement, @announcements.first
      end
    end

    context "Annoncement.current with hidetime before current announcement" do
      setup do
        @announcements = Announcement.current 2.weeks.ago
      end

      should "return only the current announcement" do
        assert_equal 1, @announcements.size
        assert_equal @current_announcement, @announcements.first
      end
    end

    context "Announcement.current with hidetime after current announcement" do
      setup do
        @announcements = Announcement.current 1.week.ago
      end

      should "not return any results" do
        assert_equal 0, @announcements.size, "expected to be empty, but contained: #{@announcements.inspect}"
      end

    end
  end
end
