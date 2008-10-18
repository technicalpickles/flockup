ActionController::Routing::Routes.draw do |map|
  map.resources :flockers
  map.resources :flocks, :has_many => :flockers
  map.root :controller => 'dashboard', :action => 'index'
  map.dashboard_search '/dashboard/search', :controller => 'dashboard', :action => 'search'
end
