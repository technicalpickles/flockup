class FlockerWorker < Workling::Base
  def verify(options)
    flocker = Flocker.find(options[:id])
    logger.info("#{flocker.twitter_username}: about to verify (currently #{flocker.status})")
    flocker.verify!
    logger.info("#{flocker.twitter_username}: updated status to #{flocker.status}")
  end
end