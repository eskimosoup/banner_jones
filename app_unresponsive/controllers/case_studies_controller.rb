class CaseStudiesController < ApplicationController
  
  def index
  	if params[:tag]
  	  @title = "Case Studies: #{params[:tag]}"
      @search = CaseStudy.active.position.tagged_with(params[:tag].to_s, :on => "tags")
    else
      @title = "Case Studies"
      @search = CaseStudy.active.position
    end
    @case_studies = @search.paginate(:page => params[:page], :per_page => 20)
  end  

  def show
    @case_study = CaseStudy.find(params[:id])
    unless @case_study.active?
      redirect_to case_studies_path
    end
  end
  
end
