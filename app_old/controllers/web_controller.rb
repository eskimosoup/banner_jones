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

  def wills_enquiry
    render :layout => false
  end

  def deliver_wills_enquiry
    if params[:email].blank? && params[:tel].blank?
      flash[:error] = "Please enter either an email or telephone number so that we can get back to you and select a relevant area of enquiry."
			render :wills_enquiry
    elsif !params[:email].blank? && !params[:email].eql?(params[:confirm_email])
      flash[:error] = "E-mail address entered was not correctly confirmed."
			render :wills_enquiry
		#elsif !verify_recaptcha
      #flash[:error] = "The code you have entered has failed validation"
			#render :wills_enquiry
    else
      name = []
      name << params[:first_name] if !params[:first_name].blank?
      name << params[:surname] if !params[:surname].blank?
      name = name.join(" ")
			Mailer.deliver_wills_enquiry(params[:title], name, params[:email], params[:tel], params[:enquiry])
			flash[:notice] = "Your enquiry has been sent to one of our experts who will contact you in the next working day."
			redirect_to :controller => "web", :action => "thank_you", :contact_us => false
		end
  end

  def site_search
    if params[:search]
      results = Search.site(params[:search])
      @results = results.paginate(:page => params[:page], :per_page => 10)
    else
      @results = []
    end
  end

  def sitemap
    respond_to do |format|
      format.html do
        @roots = PageNode.active.roots.sort_by{|s| s.name}
      end
      format.xml
    end
  end

  def contact_us
  	@page_node = PageNode.contact_us
  end

  def deliver_contact_us
    redirect_link = {:controller => "web", :action => "contact_us", :pcm => params[:pcm], :title => params[:title], :first_name => params[:first_name],
                     :surname => params[:surname], :email => params[:email], :confirm_email => params[:confirm_email], :tel => params[:tel],
                     :enquiry => params[:enquiry], :department => params[:department], :heard_about => params[:heard_about], :preferred_office => params[:preferred_office]}
    if params[:email].blank? && params[:tel].blank?
      flash[:error] = "Please enter either an email or telephone number so that we can get back to you and select a relevant area of enquiry."
			redirect_to redirect_link
    elsif !params[:email].blank? && !params[:email].eql?(params[:confirm_email])
      flash[:error] = "E-mail address entered was not correctly confirmed."
			redirect_to redirect_link
		elsif !params[:privacy_policy]
		  flash[:error] = "Please confirm that you have read the privacy policy."
		  redirect_to redirect_link
		elsif !params[:disclaimer]
		  flash[:error] = "Please confirm that you have read our disclaimer."
		  redirect_to redirect_link
		elsif !verify_recaptcha
      flash[:error] = "The code you have entered has failed validation"
			redirect_to redirect_link
    else
      name = []
      name << params[:first_name] if !params[:first_name].blank?
      name << params[:surname] if !params[:surname].blank?
      name = name.join(" ")
      if params[:department].eql?("Select...")
				department = "Not provided"
      else
				begin
	        department = params[:department]
				rescue ActiveRecord::RecordNotFound
					department = "Not Found"
				end
      end
			Mailer.deliver_contact_us(params[:title], name, params[:email], params[:tel], params[:pcm], params[:enquiry], department, params[:heard_about], params[:preferred_office])
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
