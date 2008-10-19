RAILS_GEM_VERSION = '2.1.1' unless defined? RAILS_GEM_VERSION
PROJECT_NAME = 'flockup'

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
  config.action_controller.session = {
    :session_key => '_flockup_session',
    :secret      => '4272c5ce1acd52e7ed51d19664a7c70fefc212e551667556332e083a560fd04a5227be66236793f11093e37a956410d522f96e6ec8f296772bce133ce3bb66fc'
  }
  config.gem 'haml'
  config.gem 'mislav-will_paginate',      
                                          :lib => 'will_paginate', 
                                          :source => 'http://gems.github.com/'
  config.load_paths += Dir.glob(File.join(RAILS_ROOT, 'vendor', 'gems', '*', 'lib'))
   # config.gem 'fiveruns_tuneup'
end
