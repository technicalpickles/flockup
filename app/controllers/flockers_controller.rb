class FlockersController < ApplicationController
  resources_controller_for :flockers, :only => [:index, :new]
end
