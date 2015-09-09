class OfficesController < ApplicationController
  def index
    @search  = Office.active
    @offices = @search.paginate(:page => params[:page], :per_page => 20)
  end  

  def show
    @office = Office.find(params[:id])
  end
end