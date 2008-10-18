set :stages, %w(staging production)
set :default_stage, 'staging'
set :ssh_options, { :forward_agent => true }
set :rake, "/opt/ruby-enterprise-1.8.6-20080810/bin/rake"

set :application, 'flockup'

# Who are we?
set :repository, "git@github.com:railsrumble/the-presidential-vampire-league.git"
set :scm, "git"
set :deploy_via, :remote_cache

# Deploy details
set :user, "deploy"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :use_sudo, false
set :checkout, 'export'

# We need to know how to use mongrel
set :mongrel_rails, '/opt/ruby-enterprise-1.8.6-20080810/bin/mongrel_rails'
set (:mongrel_cluster_config) {"#{deploy_to}/#{current_dir}/config/mongrel_cluster_production.yml"}

ssh_options[:paranoid] = false

gem 'capistrano-ext'
require 'capistrano/ext/multistage'

before "deploy:setup", "db:password"

namespace :deploy do
  desc "Default deploy - updated to run migrations"
  task :default do
    set :migrate_target, :latest
    update_code
    migrate
    symlink
    restart
  end
  desc "Start the mongrels"
  task :start do
    run "#{mongrel_rails} cluster::start --config #{mongrel_cluster_config}"
  end
  desc "Stop the mongrels"
  task :stop do
    run "#{mongrel_rails} cluster::stop --config #{mongrel_cluster_config}"
  end
  desc "Restart the mongrels"
  task :restart do
    run "#{mongrel_rails} cluster::restart --config #{mongrel_cluster_config}"
  end
  desc "Run this after every successful deployment" 
  task :after_default do
    cleanup
  end
end

namespace :db do
  desc "Create database password in shared path" 
  task :password do
    set :db_password, Proc.new { Capistrano::CLI.password_prompt("Remote database password: ") }
    run "mkdir -p #{shared_path}/config" 
    put db_password, "#{shared_path}/config/dbpassword" 
  end
end
