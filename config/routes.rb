ActionController::Routing::Routes.draw do |map|
  map.resources :flockers
  map.resources :flocks, :has_many => :flockers
  

end
