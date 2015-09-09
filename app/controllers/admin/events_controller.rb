class Admin::EventsController < Admin::AdminController
  
  handles_images_for Event

  def index
    @search = Event.unrecycled.search(params[:search])
    @events = @search.paginate(:page => params[:page], :per_page => 50)    
  end  

  def new
    @event = Event.new
  end  

  def create
    @event = Event.new(params[:event])
    if @event.save
      flash[:notice] = "Successfully created Event."
      if Event.image_changes?(params[:event])
        redirect_to :action => "index_images", :id => @event.id
      else
        redirect_to admin_events_path
      end
    else
      render :action => 'new'
    end
  end  

  def edit
    @event = Event.find(params[:id])
  end  

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      flash[:notice] = "Successfully updated Event."
      if Event.image_changes?(params[:event])
        redirect_to :action => "index_images", :id => @event.id
      else
        redirect_to admin_events_path
      end
    else
      render :action => 'edit'
    end
  end  

  def order
    params[:draggable].each_with_index do |id, index|
      Event.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end  

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:notice] = "Successfully destroyed Event."
    redirect_to admin_events_path
  end
  
end
