set :application, 'flockup'
set :domain, "deploy@twitterflocks.r08.railsrumble.com"
set :deploy_to, "/home/deploy/apps/flockup"
set :repository, "git@github.com:railsrumble/the-presidential-vampire-league.git"
set :revision, "origin/production"
set :use_sudo, false
set :mongrel_command, '/opt/ruby-enterprise-1.8.6-20080810/bin/mongrel_rails'

set :keep_releases, 5