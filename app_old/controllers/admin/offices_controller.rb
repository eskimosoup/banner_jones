class Admin::OfficesController < Admin::AdminController

  handles_images_for Office

  def index
    @search = Office.unrecycled.search(params[:search])
    @offices = @search.paginate(:page => params[:page], :per_page => 50)    
  end  

  def new
    @office = Office.new
  end  

  def create
    @office = Office.new(params[:office])
    if @office.save
      flash[:notice] = "Successfully created office."
      if Office.image_changes?(params[:office])
        redirect_to :action => "index_images", :id => @office.id
      else
        redirect_to admin_offices_path
      end
    else
      render :action => 'new'
    end
  end  

  def edit
    @office = Office.find(params[:id])
  end  

  def update
    @office = Office.find(params[:id])
    if @office.update_attributes(params[:office])
      flash[:notice] = "Successfully updated office."
      if Office.image_changes?(params[:office])
        redirect_to :action => "index_images", :id => @office.id
      else
        redirect_to admin_offices_path
      end
    else
      render :action => 'edit'
    end
  end  

  def order
    params[:draggable].each_with_index do |id, index|
      Office.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end  

  def destroy
    @office = Office.find(params[:id])
    @office.destroy
    flash[:notice] = "Successfully destroyed office."
    redirect_to admin_offices_path
  end
end
