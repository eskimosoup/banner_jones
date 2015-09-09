class Admin::HomeHighlightsController < Admin::AdminController

  handles_images_for HomeHighlight

  def index
    @home_highlights = HomeHighlight.unrecycled.position.search(params[:search])
  end  

  def new
    @home_highlight = HomeHighlight.new
  end  

  def create
    @home_highlight = HomeHighlight.new(params[:home_highlight])
    if @home_highlight.save
      flash[:notice] = "Successfully created home highlight."
      if HomeHighlight.image_changes?(params[:home_highlight])
        redirect_to :action => "index_images", :id => @home_highlight.id
      else
        redirect_to admin_home_highlights_path
      end
    else
      render :action => 'new'
    end
  end  

  def edit
    @home_highlight = HomeHighlight.find(params[:id])
  end  

  def update
    @home_highlight = HomeHighlight.find(params[:id])
    if @home_highlight.update_attributes(params[:home_highlight])
      flash[:notice] = "Successfully updated home highlight."
      if HomeHighlight.image_changes?(params[:home_highlight])
        redirect_to :action => "index_images", :id => @home_highlight.id
      else
        redirect_to admin_home_highlights_path
      end
    else
      render :action => 'edit'
    end
  end  
  
  def update_home
    SiteSetting.like("home button 1").first.update_attribute(:value, params[:button_1])
    SiteSetting.like("home button 2").first.update_attribute(:value, params[:button_2])
    SiteSetting.like("home button 3").first.update_attribute(:value, params[:button_3])
    SiteSetting.like("home button 4").first.update_attribute(:value, params[:button_4])
    SiteSetting.like("home button 5").first.update_attribute(:value, params[:button_5])
    SiteSetting.like("home button 6").first.update_attribute(:value, params[:button_6])
    flash[:notice] = "Home Page Updated"
    redirect_to :back
  end 

  def order
    params[:draggable].each_with_index do |id, index|
      HomeHighlight.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end  

  def destroy
    @home_highlight = HomeHighlight.find(params[:id])
    @home_highlight.destroy
    flash[:notice] = "Successfully destroyed home highlight."
    redirect_to admin_home_highlights_path
  end
end
