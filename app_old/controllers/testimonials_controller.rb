class TestimonialsController < ApplicationController
  
  def index
    if params[:tag]
      @search = Testimonial.active.position.tagged_with(params[:tag], :on => "tags")
    else
    	@search = Testimonial.active.position
    end  	
    @testimonials = @search.paginate(:page => params[:page], :per_page => 20)
  end  
  
end
