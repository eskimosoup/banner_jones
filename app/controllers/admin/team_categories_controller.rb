class Admin::TeamCategoriesController < Admin::AdminController
  def index
    @search = TeamCategory.unrecycled.position.search(params[:search])
    @team_categories = @search.paginate(:page => params[:page], :per_page => 50)    
  end  

  def new
    @team_category = TeamCategory.new
  end  

  def create
    @team_category = TeamCategory.new(params[:team_category])
    if @team_category.save
      flash[:notice] = "Successfully created team category."
      redirect_to admin_team_categories_path
    else
      render :action => 'new'
    end
  end  

  def edit
    @team_category = TeamCategory.find(params[:id])
  end  

  def update
    @team_category = TeamCategory.find(params[:id])
    if @team_category.update_attributes(params[:team_category])
      flash[:notice] = "Successfully updated team category."
      redirect_to admin_team_categories_path
    else
      render :action => 'edit'
    end
  end  

  def order
    params[:draggable].each_with_index do |id, index|
      TeamCategory.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end  

  def destroy
    @team_category = TeamCategory.find(params[:id])
    @team_category.destroy
    flash[:notice] = "Successfully destroyed team category."
    redirect_to admin_team_categories_path
  end
end
