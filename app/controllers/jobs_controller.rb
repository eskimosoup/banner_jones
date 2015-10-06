class JobsController < ApplicationController

  def index
    @search = Job.active.order
    @jobs = @search.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @job  = Job.find(params[:id])
    @jobs = Job.job_id_not(@job.id).in_office(@job.office_ids).active.order
  end

end
