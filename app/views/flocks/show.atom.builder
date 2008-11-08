atom_feed do |feed|
  feed.title("#{@flock.name} flockers")

  feed.link(flock_url(@flock))
  @flock.flockers.each do |flocker|
    feed.entry(flocker, :published => flocker.created_at, :updated => flocker.updated_at) do |entry|
      entry.title(flocker.twitter_username)
    end
  end
end

