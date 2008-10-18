Factory.define :flock do |flock|
  flock.name { Factory.next(:flock_name) }
  flock.description 'MyText'
end

Factory.sequence :flock_name do |n|
  "myflock#{n}"
end