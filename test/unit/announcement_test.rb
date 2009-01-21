require File.dirname(__FILE__) + '/../test_helper'

class AnnouncementTest < ActiveSupport::TestCase
  should_require_attributes :message, :starts_at, :ends_at
end
