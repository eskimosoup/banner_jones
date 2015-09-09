class JobsController < ApplicationController
  
  def index
    @search = Job.active.order
    @jobs = @search.paginate(:page => params[:page], :per_page => 10)
  end
  
  def show
    @job  = Job.find(params[:id])
    @jobs = Job.active.order.offices_id_contains_any(@job.office_ids).reject{|job|job == @job}
  end
  
end
