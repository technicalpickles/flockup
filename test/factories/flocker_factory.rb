Factory.define :flocker do |flocker|
  flocker.twitter_username { Factory.next(:twitter_username) }
end

Factory.sequence :twitter_username do |n|
  "twitterer#{n}"
end