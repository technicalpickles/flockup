begin
  STARLING_CONFIG = YAML.load_file("#{File.dirname(__FILE__)}/../../../../config/starling.yml")[RAILS_ENV]
  STARLING_LOG = Logger.new(STARLING_CONFIG['log_file'])
  STARLING = Starling.new("#{STARLING_CONFIG['host']}:#{STARLING_CONFIG['port']}")
end

module Simplified

  class Starling

    def self.autoload_missing_constants
      yield
    rescue ArgumentError, MemCache::MemCacheError => error
      lazy_load ||= Hash.new { |hash, key| hash[key] = true; false }
      retry if error.to_s.include?('undefined class') && 
        !lazy_load[error.to_s.split.last.constantize]
      raise error
    end

    def self.running?
      config = YAML.load_file("#{RAILS_ROOT}/config/starling.yml")[RAILS_ENV]
      if File.exist?(config['pid_file'])
        Process.getpgid(File.read(config['pid_file']).to_i) rescue return false
      else
        return false
      end
    end

    def self.prepare(queue)
      self.feedback("Queue processor started for `#{queue}`.")
      start_processing(queue)
    end

    def self.process(queue, daemonize = true)

      pid = fork do
        Signal.trap('HUP', 'IGNORE') # Don't die upon logout
        loop { pop(queue) }
      end

      if daemonize

        ##
        # Write pid file in pid folder
        #
        File.open(STARLING_CONFIG['queue_pid_file'], "w") do |pid_file|
          pid_file.puts pid
        end

        ##
        # Detach process
        #
        Process.detach(pid)

      end

    end

    def self.pop(queue)
      begin
        job = autoload_missing_constants { STARLING.get(queue) }
        args = [job[:task]] + job[:options] # what to send to the object
        if job[:id]
          job[:type].constantize.find(job[:id]).send(*args)
        else
          job[:type].constantize.send(*args)
        end
        STARLING_LOG.info "[#{Time.now.to_s(:db)}] Popped #{job[:task]} on #{job[:type]} #{job[:id]}"
      rescue ActiveRecord::RecordNotFound
        STARLING_LOG.warn "[#{Time.now.to_s(:db)}] WARNING #{job[:type]}##{job[:id]} gone from database."
      rescue ActiveRecord::StatementInvalid
        STARLING_LOG.warn "[#{Time.now.to_s(:db)}] WARNING Database connection gone, reconnecting & retrying."
        ActiveRecord::Base.connection.reconnect! and retry
      rescue Exception => error
        STARLING_LOG.error "[#{Time.now.to_s(:db)}] ERROR #{error.message}"
      end
    end

    def self.stats
      config_file = File.dirname(__FILE__) + "/../../../../config/starling.yml"
      config = YAML.load_file(config_file)[RAILS_ENV]
      return config['queue'], STARLING.sizeof(config['queue'])
    end

    def self.feedback(message)
      puts "=> [SIMPLIFIED STARLING] #{message}"
    end

  end

end