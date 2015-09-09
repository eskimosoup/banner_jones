class Admin::TeamMembersController < Admin::AdminController

  handles_images_for TeamMember

  def index
    @search = TeamMember.position.unrecycled.search(params[:search])
    @team_members = @search.paginate(:page => params[:page], :per_page => 50)    
  end  

  def new
    @team_member = TeamMember.new
  end  

  def create
    @team_member = TeamMember.new(params[:team_member])
    if @team_member.save
      flash[:notice] = "Successfully created team member."
      if TeamMember.image_changes?(params[:team_member])
        redirect_to :action => "index_images", :id => @team_members.id
      else
        redirect_to admin_team_members_path
      end
    else
      render :action => 'new'
    end
  end  

  def edit
    @team_member = TeamMember.find(params[:id])
  end  

  def update
    params[:team_member][:page_node_ids] ||= []
    params[:team_member][:team_category_ids] ||= []
    params[:team_member][:testimonial_ids] ||= []
    @team_member = TeamMember.find(params[:id])
    if @team_member.update_attributes(params[:team_member])
      flash[:notice] = "Successfully updated team member."
      if TeamMember.image_changes?(params[:team_member])
        redirect_to :action => "index_images", :id => @team_member.id
      else
        redirect_to admin_team_members_path
      end
    else
      render :action => 'edit'
    end
  end  

  def order
    params[:draggable].each_with_index do |id, index|
      TeamMember.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end  

  def destroy
    @team_member = TeamMember.find(params[:id])
    @team_member.destroy
    flash[:notice] = "Successfully destroyed team member."
    redirect_to admin_team_members_path
  end
end
