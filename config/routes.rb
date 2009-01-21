ActionController::Routing::Routes.draw do |map|
  map.resources :announcements, :collection => { :hide => :get }

  map.resources :flockers
  map.resources :flocks, :has_many => :flockers

  map.resources :searches, :as => 'search'

  map.root :controller => 'dashboard', :action => 'index'

  map.dashboard_search '/dashboard/search', :controller => 'dashboard', :action => 'search'
  map.about '/pages/about', :controller => 'pages', :action => 'about'
  map.terms_of_service '/pages/terms_of_service', :controller => 'pages', :action => 'terms_of_service'
  map.contact '/pages/contact', :controller => 'pages', :action => 'contact'
end
