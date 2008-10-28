class FlocksController < ApplicationController
  resources_controller_for :flocks, :only => [:index, :new, :show, :create]
  
  def index
    self.resources = find_resources
  end
  
  def new
    self.resource = new_resource
  end
  
  def show
    self.resource = find_resource
    redirect_to self.resource, :status => 301 if self.resource.has_better_id?
    @flocker = self.resource.flockers.build
  end

  def create
    self.resource = resource_service.find_by_name params[:flock][:name]
    if resource
      flash[:notice] = "There is already a flock named #{params[:flock][:name]}.  Here it is:"
      redirect_to resource_url
    else
      self.resource = new_resource

      if resource.save
        flash[:notice] = 'Flock was successfully created.'
        redirect_to resource_url
      else
        render :action => "new"
      end
    end
  end

protected
  def find_resources
    resource_service.paginate :page => params[:page]
  end
  
end