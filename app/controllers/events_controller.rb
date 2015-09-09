class EventsController < ApplicationController

  def index
    params[:page] ||= 1
    if params[:tag]
      @title = "Events: #{params[:tag]}"
      @search = Event.active.tagged_with(params[:tag].to_s, :on => "tags")
    elsif params[:year] && params[:month]
      @title = "Events: #{Date::MONTHNAMES[params[:month].to_i]} #{params[:year]}"
      @search = Event.active.start_year(params[:year]).start_month(params[:month])
    elsif params[:year]
      @title = "Events: #{params[:year]}"
      @search = Event.active.start_year(params[:year])
    else
      @title = "Events"
      @search = Event.active
    end
    @events = @search.upcoming.paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @event = Event.find(params[:id])

    unless @event.active?
      redirect_to events_path
    end

    if request.post?
      if params[:email].blank? && params[:phone_number].blank?
        flash.now[:error] = "Please enter either an email or telephone number so that we can contact you about your booking request."
      elsif !params[:email].blank? && !params[:email].eql?(params[:confirm_email])
        flash.now[:error] = "E-mail address entered was not correctly confirmed."
      elsif !params[:privacy_policy]
        flash.now[:error] = "Please confirm that you have read the privacy policy."
      #elsif !verify_recaptcha
      #  flash.now[:error] = "The code you have entered has failed validation"
      else
        Mailer.deliver_booking_request(@event.name, params[:name], params[:email], params[:phone_number], params[:no_of_places], params[:additional_names])
        flash.now[:notice] = "Your booking request has been sent."
      end
    end
  end

end
