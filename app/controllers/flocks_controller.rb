class FlocksController < ApplicationController
  resources_controller_for :flocks, :only => [:index, :new]
  
  def show
    self.resource = find_resource
    @flocker = self.resource.flockers.build
  end
  
  # POST /flocks
  # POST /flocks.xml
  def create
    flock = Flock.find(:first, :conditions => ['name = ?', params[:flock][:name]])
    if flock
      flash[:notice] = "There is already a flock named #{params[:flock][:name]}."
      redirect_to :action => 'show', :id => flock
    else
      @flock = Flock.new(params[:flock])

      respond_to do |format|
        if @flock.save
          flash[:notice] = 'Flock was successfully created.'
          format.html { redirect_to(@flock) }
          format.xml  { render :xml => @flock, :status => :created, :location => @flock }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @flock.errors, :status => :unprocessable_entity }
        end
      end
    end
  end
  
end