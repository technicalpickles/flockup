require 'starling'
require "#{RAILS_ROOT}/vendor/plugins/simplified_starling/lib/simplified_starling"

namespace :simplified_starling do

  desc "Start starling server"
  task :start do
    config = YAML.load_file("#{RAILS_ROOT}/config/starling.yml")[RAILS_ENV]
    unless Simplified::Starling.running?
      starling_binary = `which starling`.strip
      raise RuntimeError, "Cannot find starling" if starling_binary.blank?
      options = []
      options << "--queue_path #{config['queue_path']}"
      options << "--host #{config['host']}"
      options << "--port #{config['port']}"
      options << "-d" if config['daemonize']
      options << "--pid #{config['pid_file']}"
      # options << "--syslog #{config['syslog_channel']}"
      options << "--timeout #{config['timeout']}"
      system "#{starling_binary} #{options.join(' ')}"
      Simplified::Starling.feedback("Starling successfully started")
    else
      Simplified::Starling.feedback("Starling is already running")
    end
  end

  desc "Stop starling server"
  task :stop do
    config = YAML.load_file("#{RAILS_ROOT}/config/starling.yml")[RAILS_ENV]
    pid_file = config['pid_file']
    if File.exist?(pid_file)
      system "kill -9 `cat #{pid_file}`"
      Simplified::Starling.feedback("Starling successfully stopped")
      File.delete(pid_file)
    else
      Simplified::Starling.feedback("Starling is not running")
    end
  end

  desc "Restart starling server"
  task :restart do
    config = YAML.load_file("#{RAILS_ROOT}/config/starling.yml")[RAILS_ENV]
    pid_file = config['pid_file']
    Rake::Task['simplified_starling:stop'].invoke if File.exist?(pid_file)
    Rake::Task['simplified_starling:start'].invoke
  end

  desc "Start processing jobs (process is daemonized)"
  task :start_processing_jobs => :environment do
    begin
      config = YAML.load_file("#{RAILS_ROOT}/config/starling.yml")[RAILS_ENV]
      queue_pid_file = config['queue_pid_file']
      unless File.exist?(queue_pid_file)
        Simplified::Starling.stats
        Simplified::Starling.process(config['queue'])
        Simplified::Starling.feedback("Started processing jobs")
      else
        Simplified::Starling.feedback("Jobs are already being processed")
      end
    rescue Exception => error
      Simplified::Starling.feedback(error.message)
    end
  end
  
  desc "Process just one job"
  task :process_job => :environment do
    begin
      config = YAML.load_file("#{RAILS_ROOT}/config/starling.yml")[RAILS_ENV]
      queue_pid_file = config['queue_pid_file']
      unless File.exist?(queue_pid_file)
        Simplified::Starling.stats
        Simplified::Starling.pop(config['queue'])
        Simplified::Starling.feedback("Started processing jobs")
      else
        Simplified::Starling.feedback("Jobs are already being processed")
      end
    rescue Exception => error
      Simplified::Starling.feedback(error.message)
    end
  end

  desc "Stop processing jobs"
  task :stop_processing_jobs do
    config = YAML.load_file("#{RAILS_ROOT}/config/starling.yml")[RAILS_ENV]
    queue_pid_file = config['queue_pid_file']
    if File.exist?(queue_pid_file)
      system "kill -9 `cat #{queue_pid_file}`"
      Simplified::Starling.feedback("Stopped processing jobs")
      File.delete(queue_pid_file)
    else
      Simplified::Starling.feedback("Jobs are not being processed")
    end
  end

  desc "Start starling and process jobs"
  task :start_and_process_jobs do
    Rake::Task['simplified_starling:start'].invoke
    sleep 10
    Rake::Task['simplified_starling:start_processing_jobs'].invoke
  end

  desc "Start starling and process one job"
  task :start_and_process_job do
    Rake::Task['simplified_starling:start'].invoke
    sleep 10
    Rake::Task['simplified_starling:process_job'].invoke
  end

  desc "Server stats"
  task :stats do
    begin
      queue, items = Simplified::Starling.stats
      Simplified::Starling.feedback("Queue has #{items} jobs")
    rescue Exception => error
      Simplified::Starling.feedback(error.message)
    end
  end

end