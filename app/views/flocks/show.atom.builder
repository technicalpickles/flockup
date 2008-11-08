xml.instruct! :xml, :version=>"1.0" 
xml.feed(:xmlns => "http://www.w3.org/2005/Atom") do |feed|
  feed.title('Atom Feed')
  feed.link(flock_url(@flock))
  @flock.flockers.each do |flocker|
    feed.entry do |entry|
      entry.id(flocker.id)
      entry.title(flocker.twitter_username)
      entry.link(flocker_url(flocker))
    end
  end
end

