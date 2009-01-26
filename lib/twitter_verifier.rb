module TwitterVerifier
  def valid_username?()
    ! lookup_twitter_user(self.twitter_username).nil?
  end
  
protected

  def lookup_twitter_user(username)
    begin
      twitter.user(self.twitter_username)
    rescue Twitter::CantConnect => e
      if e.message =~ /404/
        nil
      else
        raise
      end
    end
  end
  
  # FIXME remove redudancy with TwitterNotifier
  def twitter
    @twitter ||= Twitter::Base.new('tweetfleet', 'v4mp1r3')
  end
end
