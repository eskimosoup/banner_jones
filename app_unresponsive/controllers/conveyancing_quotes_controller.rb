class ConveyancingQuotesController < ApplicationController

  include ActionView::Helpers::NumberHelper
  
  def index
    redirect_to new_conveyancing_quote_path
  end
  
  def show
    @conveyancing_quote = ConveyancingQuote.find(params[:id])
    @cq = @conveyancing_quote
    unless params[:p] == @conveyancing_quote.passcode
      flash[:error] = "You do not have permission to view this content."
      redirect_to new_conveyancing_quote_path
    end
  end
  
  def pdf_for
    @conveyancing_quote = ConveyancingQuote.find(params[:id])
    @cq = @conveyancing_quote
    unless params[:p] == @conveyancing_quote.passcode
      flash[:error] = "You do not have permission to view this content."
      redirect_to new_conveyancing_quote_path
    end
    @hide = true
    render :action => 'show', :layout => 'simple'
  end
  
  def download_pdf
    @conveyancing_quote = ConveyancingQuote.find(params[:id])
    @cq = @conveyancing_quote
    unless params[:p] == @conveyancing_quote.passcode
      flash[:error] = "You do not have permission to view this content."
      redirect_to new_conveyancing_quote_path
      return
    end
    @cq.generate_pdf(pdf_for_conveyancing_quote_url(@cq, :p => @cq.passcode))
    send_file @cq.pdf_path
  end
  
  def new
    @conveyancing_quote = ConveyancingQuote.new
  end  
  
  def create
    @cq = ConveyancingQuote.new(params[:conveyancing_quote].merge!(:status => "Quote Generated"))
    @conveyancing_quote = @cq
    if @cq.save
      Mailer.deliver_conveyancing_quote_to_user(@cq, pdf_for_conveyancing_quote_url(@cq, :p => @cq.passcode))
      Mailer.deliver_conveyancing_quote_to_admin(@cq, pdf_for_conveyancing_quote_url(@cq, :p => @cq.passcode, :a => true), 'Quote Generated')
      redirect_to conveyancing_quote_path(@cq, :p => @cq.passcode)
    else
      render :action => 'new'
    end
  end
  
  def update_type_fields
    render :update  do |page|
      page[:type_fields].replace :partial => "conveyancing_quotes/form/" + ConveyancingQuote.conveyancing_types_to_form_partial(params[:conveyancing_type])
    end
  end
  
  def register_interest
    @cq = ConveyancingQuote.find(params[:id])
    @cq.update_attribute(:status, "Interest Registered")
    Mailer.deliver_conveyancing_quote_to_admin(@cq, pdf_for_conveyancing_quote_url(@cq, :p => @cq.passcode), 'Interest Registered')
    flash[:notice] = "Thank you! Our conveyancing team has been emailed the details of your request and will get back to you as soon as possible."
    redirect_to conveyancing_quote_path(@cq, :p => @cq.passcode)
  end
    
end
