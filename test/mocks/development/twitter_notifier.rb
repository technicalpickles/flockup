module TwitterNotifier
  def notify_on_twitter(message)
    message_with_to = "@#{self.twitter_username} #{message}"
    logger.info "About to twitter: #{message_with_to}"
  end
end