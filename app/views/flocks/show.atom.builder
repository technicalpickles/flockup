atom_feed do |feed|
  feed.title("#{@flock.name} flockers")
  feed.updated(@flock.flockers.first.created_at)

  @flock.flockers.each do |flocker|
    feed.entry(flocker) do |entry|
      entry.title(flocker.twitter_username)
    end
  end
end

