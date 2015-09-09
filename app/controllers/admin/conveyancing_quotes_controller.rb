class Admin::ConveyancingQuotesController < Admin::AdminController
  def index
    params[:search] ||= {}
    @search = ConveyancingQuote.unrecycled.search(params[:search])
    @conveyancing_quotes = @search.paginate(:page => params[:page], :per_page => 50)    
  end  

  def edit
    @conveyancing_quote = ConveyancingQuote.find(params[:id])
  end  

  def update
    @conveyancing_quote = ConveyancingQuote.find(params[:id])
    if @conveyancing_quote.update_attributes(params[:conveyancing_quote])
      flash[:notice] = "Successfully updated conveyancing quote."
      redirect_to admin_conveyancing_quotes_path
    else
      render :action => 'edit'
    end
  end  

  def order
    params[:draggable].each_with_index do |id, index|
      ConveyancingQuote.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end  

  def destroy
    @conveyancing_quote = ConveyancingQuote.find(params[:id])
    @conveyancing_quote.destroy
    flash[:notice] = "Successfully destroyed conveyancing quote."
    redirect_to admin_conveyancing_quotes_path
  end
  
  def close
    @conveyancing_quote = ConveyancingQuote.find(params[:id])
    @conveyancing_quote.update_attribute(:status, "Closed")
    flash[:notice] = "Conveyancing quote closed."
    redirect_to admin_conveyancing_quotes_path
  end
  
  def reopen
    @conveyancing_quote = ConveyancingQuote.find(params[:id])
    @conveyancing_quote.update_attribute(:status, "Quote Generated")
    flash[:notice] = "Conveyancing quote re-opened."
    redirect_to admin_conveyancing_quotes_path
  end
end
