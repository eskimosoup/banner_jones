class Admin::VideosController < Admin::AdminController

  handles_images_for Video

  def index
    @search = Video.unrecycled.search(params[:search])
    @videos = @search.paginate(:page => params[:page], :per_page => 50)    
  end  

  def new
    @video = Video.new
  end  

  def create
    @video = Video.new(params[:video])
    if @video.save
      flash[:notice] = "Successfully created video."
      redirect_to admin_videos_path
    else
      render :action => 'new'
    end
  end  

  def edit
    @video = Video.find(params[:id])
  end  

  def update
    @video = Video.find(params[:id])
    if @video.update_attributes(params[:video])
      flash[:notice] = "Successfully updated video."
      redirect_to admin_videos_path
    else
      render :action => 'edit'
    end
  end  

  def order
    params[:draggable].each_with_index do |id, index|
      Video.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end  

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    flash[:notice] = "Successfully destroyed video."
    redirect_to admin_videos_path
  end
end
