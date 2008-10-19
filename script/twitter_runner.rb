require File.dirname(__FILE__) + '/../config/environment'
require 'pp'

$running = true
Signal.trap("TERM") do 
  $running = false
end

logger = Logger.new(STDOUT)

twitter = Twitter::Base.new('flockup', 'v4mp1r3')

starling_config = YAML.load_file("#{RAILS_ROOT}/config/starling.yml")[RAILS_ENV]
starling_pid_file = starling_config['queue_pid_file']

starling_queue = starling_config['queue']

# require 'mocha'
# time = Time.now + 20.seconds
# status = Twitter::RateLimitStatus.new
# status.reset_time_in_seconds = time.to_i
# status.reset_time = time
# status.remaining_hits = 0
# twitter.stubs(:rate_limit_status).returns(status)

while($running) do
  queue_size = Simplified::Starling.stats.last
  if queue_size > 0
    logger.info "#{queue_size} jobs in queue"
    api_status = twitter.rate_limit_status
    if api_status.remaining_hits > 0
      logger.info "Twitter API still good. #{api_status.remaining_hits} remaining"
    
      unless File.exist?(starling_pid_file)
        logger.info "Kicking off job"
        Simplified::Starling.pop(starling_queue)
      else
        logger.info "Aieee, #{queue_pid_file} missing. Is starling running?"
      end
    else

      time_to_sleep = api_status.reset_time_in_seconds - Time.now.to_i
      puts "Gah, limit hit. Sleeping until #{api_status.reset_time} (#{time_to_sleep} seconds)"
      sleep time_to_sleep if time_to_sleep > 0
    end
  else
    logger.info "Nothin to run"
    sleep 5
  end
end