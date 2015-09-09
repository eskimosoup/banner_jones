class Admin::HomepageButtonsController < Admin::AdminController

  handles_images_for HomepageButton
  
  def index
    redirect_to :controller => "admin/home_highlights", :action => "index_home"
  end
  
  def edit
    @homepage_button = HomepageButton.find(params[:id])
  end  

  def update
    @homepage_button = HomepageButton.find(params[:id])
    if @homepage_button.update_attributes(params[:homepage_button])
      flash[:notice] = "Successfully updated homepage button."
      if HomepageButton.image_changes?(params[:homepage_button])
        redirect_to :action => "index_images", :id => @homepage_button.id
      else
        redirect_to :controller => "admin/home_highlights", :action => "index_home"
      end
    else
      render :action => 'edit'
    end
  end  
end
