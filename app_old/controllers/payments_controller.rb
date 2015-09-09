class PaymentsController < ApplicationController

  protect_from_forgery :except => [:gateway_reply]

  def new
    @payment = Payment.new
  end
  
  def create
    @payment = Payment.new(params[:payment]) 
    if @payment.save
      redirect_to payment_path(@payment, :code => @payment.code)
    else
      render :action => "new"
    end
  end

  def index
    redirect_to new_payment_path
  end  

  def show
    @payment = Payment.find(params[:id])
    unless params[:code] == @payment.code
      flash[:error] = "You do not have permission to view this data."
      redirect_to root_url
      return
    end
  end
  
  def gateway_reply
    
  end
  
end
