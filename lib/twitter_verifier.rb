module TwitterVerifier
  def valid_username?()
    ! lookup_twitter_user(self.twitter_username).nil?
  end
  
protected

  def lookup_twitter_user(username)
    breakpoint
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
  
  def twitter
    @twitter ||= Twitter::Base.new('flockup', 'v4mp1r3')
  end
end