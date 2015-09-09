class Admin::CaseStudiesController < Admin::AdminController
  
  handles_images_for CaseStudy

  def index
    @search = CaseStudy.position.unrecycled.search(params[:search])
    @case_studies = @search.paginate(:page => params[:page], :per_page => 50)    
  end  

  def new
    @case_study = CaseStudy.new
  end  

  def create
    @case_study = CaseStudy.new(params[:case_study])
    if @case_study.save
      flash[:notice] = "Successfully created Case study."
      if CaseStudy.image_changes?(params[:case_study])
        redirect_to :action => "index_images", :id => @case_study.id
      else
        redirect_to admin_case_studies_path
      end
    else
      render :action => 'new'
    end
  end  

  def edit
    @case_study = CaseStudy.find(params[:id])
  end  

  def update
    @case_study = CaseStudy.find(params[:id])
    if @case_study.update_attributes(params[:case_study])
      flash[:notice] = "Successfully updated Case study."
      if CaseStudy.image_changes?(params[:case_study])
        redirect_to :action => "index_images", :id => @case_study.id
      else
        redirect_to admin_case_studies_path
      end
    else
      render :action => 'edit'
    end
  end  

  def order
    params[:draggable].each_with_index do |id, index|
      CaseStudy.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end  

  def destroy
    @case_study = CaseStudy.find(params[:id])
    @case_study.destroy
    flash[:notice] = "Successfully destroyed Case study."
    redirect_to admin_case_studies_path
  end
  
end
