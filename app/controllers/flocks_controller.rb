class FlocksController < ApplicationController
  resources_controller_for :flocks, :only => [:index, :new, :create, :show]
  
  def show
    self.resource = find_resource
    @flocker = self.resource.flockers.build
  end
end