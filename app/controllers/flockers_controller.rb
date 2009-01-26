class FlockersController < ApplicationController
  before_filter :load_enclosing_resources, :if => :enclosing_resource?
  resources_controller_for :flockers, :in => :flock, :only => [:index, :show, :new, :create]
  
  def index
    self.resources = find_resources
  end
  
  def show
    self.resource = find_resource
    redirect_to self.resource, :status => 301 if self.resource.has_better_id?
  end
  
  def new
    self.resource = new_resource
  end
  
  def create
    self.resource = new_resource
    
    # FIXME the controller shouldn't be doing this much work, fatten up those models
    # Alternatively, could care a lot less about the message being displayed
    if !new_resource.new_record?
      if enclosing_resource
        if enclosing_resource.flocker_ids.include?(resource.id)
          flash[:notice] = "#{resource.twitter_username} already in the #{enclosing_resource.name} flock"
        else
          flash[:notice] = "#{resource.twitter_username} added to the #{enclosing_resource.name} flock"
          enclosing_resource.flockers << resource
        end
        redirect_to enclosing_resource_url
      else
        redirect_to resource_url
      end
    elsif resource.save
      if enclosing_resource
        flash[:notice] = "#{resource.twitter_username} was added to the #{enclosing_resource.name} flock"
        enclosing_resource.flockers << resource
        redirect_to enclosing_resource_url
      else
        flash[:notice] = "#{resource.twitter_username} was successfully created."
        redirect_to resource_url
      end
    else
      render :action => "new" 
    end
  end
  
protected
  def find_resources
    self.resources = resource_service.not_invalid.find(:all, :order => :twitter_username)
  end
  
  def enclosing_resource?
    ! params[:flock_id].blank?
  end
  
  def new_resource(attributes = (params[resource_name] || {}))
    existing_resource = Flocker.find_by_twitter_username(attributes[:twitter_username])
    existing_resource || resource_service.new(attributes)
  end
end
