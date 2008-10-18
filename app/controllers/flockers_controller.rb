class FlockersController < ApplicationController
  before_filter :load_enclosing_resources, :if => :enclosing_resource?
  resources_controller_for :flockers, :in => :flock, :only => [:index, :new, :create]
  
  def create
    self.resource = new_resource
    
    respond_to do |format|
      if resource.save
        format.html do
          flash[:notice] = "#{resource_name.humanize} was successfully created."
          if enclosing_resource
            redirect_to enclosing_resource_url
          else
            redirect_to resource_url
          end
        end
        format.js
        format.xml  { render :xml => resource, :status => :created, :location => resource_url }
      else
        format.html { render :action => "new" }
        format.js   { render :action => "new" }
        format.xml  { render :xml => resource.errors, :status => :unprocessable_entity }
      end
    end
  end
  
protected
  def enclosing_resource?
    ! params[:flock_id].blank?
  end
  
  def new_resource(attributes = (params[resource_name] || {}))
    result = resource_service.new(attributes)
    enclosing_resource.flockers << result if enclosing_resource
    result
  end
end
