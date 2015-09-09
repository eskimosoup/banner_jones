class WebController < ApplicationController

	def index

	end

	def privacy
	  redirect_to :action => "privacy_policy"
	end

	def cookie
    redirect_to :action => "cookie_policy"
	end

  def site_down

  end

  def site_search
    if params[:search]
      results = Search.site(params[:search])
      @results = results.paginate(:page => params[:page], :per_page => 10)
    else
      @results = []
    end
  end

  def site_map
    @roots = PageNode.active.roots.sort_by{|s| s.name}
  end

  def contact_us
  	@page_node = PageNode.contact_us
  end

  def deliver_contact_us
    redirect_link = {:controller => "web", :action => "contact_us", :pcm => params[:pcm], :title => params[:title], :first_name => params[:first_name], :surname => params[:surname], :email => params[:email], :confirm_email => params[:confirm_email], :tel => params[:tel], :enquiry => params[:enquiry], :department => params[:department], :heard_about => params[:heard_about]}
    if params[:email].blank? && params[:tel].blank?
      flash[:error] = "Please enter either an email or telephone number so that we can get back to you and select a relevant area of enquiry."
			redirect_to redirect_link
    elsif !params[:email].blank? && !params[:email].eql?(params[:confirm_email])
      flash[:error] = "E-mail address entered was not correctly confirmed."
			redirect_to redirect_link
		elsif !params[:privacy_policy]
		  flash[:error] = "Please confirm that you have read the privacy policy."
		  redirect_to redirect_link
		elsif !verify_recaptcha
      flash[:error] = "The code you have entered has failed validation"
			redirect_to redirect_link
    else
      name = []
      name << params[:first_name] if !params[:first_name].blank?
      name << params[:surname] if !params[:surname].blank?
      name = name.join(" ")
			Mailer.deliver_contact_us(params[:title], name, params[:email], params[:tel], params[:pcm], params[:enquiry], params[:department].eql?("Select...") ? "Not provided" : PageNode.find(params[:department]).navigation_title, params[:heard_about])
			flash[:notice] = "Your enquiry has been sent to one of our experts who will contact you in the next working day."
			redirect_to :controller => "web", :action => "thank_you", :contact_us => true
		end
  end

  def family_assistance
    @family_assistance_calculation = LegalAidRequest.new(params[:family_assistance_calculation])
    #raise @fa.to_yaml
    if @family_assistance_calculation.save
      @ok = true
    else
      @ok = false
    end
  end

end
