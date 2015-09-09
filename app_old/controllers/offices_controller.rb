class OfficesController < ApplicationController
  def index
    @search  = Office.active
    @offices = @search.paginate(:page => params[:page], :per_page => 20)
  end  

  def show
    @office = Office.find(params[:id])
    if request.path != office_path(@office)
      redirect_to office_path(@office), :status => :moved_permanently
    end
    @offices = Office.active
  end
end