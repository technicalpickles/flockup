# For migrations
set :rails_env, 'production'

# Who are we?
set :branch, "production"

# Where to deploy to?
role :web, "twitterflocks.r08.railsrumble.com"
role :app, "twitterflocks.r08.railsrumble.com"
role :db,  "twitterflocks.r08.railsrumble.com", :primary => true