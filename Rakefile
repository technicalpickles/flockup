# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

begin
  require 'vlad'
  Vlad.load :scm => :git
  require 'vlad/extras'
  

rescue LoadError
end

desc "Tag the release"
task :tag => ['git:push:staging', 'git:push:production'] do
end


desc "Deploy the release"
task :deploy => ['vlad:update', 'vlad:migrate', 'vlad:start_app'] do
end