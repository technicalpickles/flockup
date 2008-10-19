module TwitterNotifier
  def notify_on_twitter(message)
    message_with_to = "@#{self.twitter_username} #{message}"
    log.info "About to twitter: #{message_with_to}"
    twitter.post(message_with_to)
  end
  
protected
  
  def twitter
    @twitter ||= Twitter::Base.new('flockup', 'v4mp1r3')
  end
end