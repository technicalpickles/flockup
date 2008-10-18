class FlockersController < ApplicationController
  def index
    @flockers = Flocker.find(:all)

    respond_to do |format|
      format.html
      format.xml  { render :xml => @flockers }
    end
  end

  def show
    @flocker = Flocker.find(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @flocker }
    end
  end

  def new
    @flocker = Flocker.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @flocker }
    end
  end

  def edit
    @flocker = Flocker.find(params[:id])
  end

  def create
    @flocker = Flocker.new(params[:flocker])

    respond_to do |format|
      if @flocker.save
        flash[:notice] = 'Flocker was successfully created.'
        format.html { redirect_to(@flocker) }
        format.xml  { render :xml => @flocker, :status => :created, :location => @flocker }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @flocker.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @flocker = Flocker.find(params[:id])

    respond_to do |format|
      if @flocker.update_attributes(params[:flocker])
        flash[:notice] = 'Flocker was successfully updated.'
        format.html { redirect_to(@flocker) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @flocker.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @flocker = Flocker.find(params[:id])
    @flocker.destroy

    respond_to do |format|
      format.html { redirect_to(flockers_url) }
      format.xml  { head :ok }
    end
  end
end
