class FlockersController < ApplicationController
  before_filter :load_enclosing_resources, :if => :enclosing_resource?
  resources_controller_for :flockers, :in => :flock, :only => [:index, :new, :create, :show]
  
  def create
    self.resource = new_resource
    
    respond_to do |format|
      if !new_resource.new_record?
        format.html do
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
        end
      elsif resource.save
        format.html do

          if enclosing_resource
            flash[:notice] = "#{resource.twitter_username} was added to the #{enclosing_resource.name} flock"
            enclosing_resource.flockers << resource
            redirect_to enclosing_resource_url
          else
            flash[:notice] = "#{resource.twitter_username} was successfully created."
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
    existing_resource = Flocker.find_by_twitter_username(attributes[:twitter_username])
    existing_resource || resource_service.new(attributes)
  end
end
