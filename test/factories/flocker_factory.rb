Factory.define :flocker do |flocker|
  flocker.twitter_username 'mystring'
end

Factory.sequence :twitter_username do |n|
  "twitterer#{n}"
end