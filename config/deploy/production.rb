# For migrations
set :rails_env, 'production'

# Who are we?
set :repository, "git@github.com:railsrumble/the-presidential-vampire-league.git"
set :scm, "git"
set :deploy_via, :remote_cache
set :branch, "production"

# Where to deploy to?
role :web, "twitterflocks.r08.railsrumble.com"
role :app, "twitterflocks.r08.railsrumble.com"
role :db,  "twitterflocks.r08.railsrumble.com", :primary => true

# Deploy details
set :user, "deploy"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :use_sudo, false
set :checkout, 'export'