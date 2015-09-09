class Admin::LegalAidRequestsController < Admin::AdminController
  def index
    @search = LegalAidRequest.unrecycled.search(params[:search])
    @legal_aid_requests = @search.paginate(:page => params[:page], :per_page => 50)    
  end  

  def new
    @legal_aid_request = LegalAidRequest.new
  end  

  def create
    @legal_aid_request = LegalAidRequest.new(params[:legal_aid_request])
    if @legal_aid_request.save
      flash[:notice] = "Successfully created legal aid request."
      redirect_to admin_legal_aid_requests_path
    else
      render :action => 'new'
    end
  end  

  def edit
    @legal_aid_request = LegalAidRequest.find(params[:id])
  end  

  def update
    @legal_aid_request = LegalAidRequest.find(params[:id])
    if @legal_aid_request.update_attributes(params[:legal_aid_request])
      flash[:notice] = "Successfully updated legal aid request."
      redirect_to admin_legal_aid_requests_path
    else
      render :action => 'edit'
    end
  end  

  def order
    params[:draggable].each_with_index do |id, index|
      LegalAidRequest.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end  

  def destroy
    @legal_aid_request = LegalAidRequest.find(params[:id])
    @legal_aid_request.destroy
    flash[:notice] = "Successfully destroyed legal aid request."
    redirect_to admin_legal_aid_requests_path
  end
end