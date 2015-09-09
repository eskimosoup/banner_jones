class Admin::TestimonialsController < Admin::AdminController
  
  handles_images_for Testimonial

  def index
    @search = Testimonial.unrecycled.position.search(params[:search])
    @testimonials = @search.paginate(:page => params[:page], :per_page => 50)    
  end  

  def new
    @testimonial = Testimonial.new
  end  

  def create
    @testimonial = Testimonial.new(params[:testimonial])
    if @testimonial.save
      flash[:notice] = "Successfully created Testimonial."
      redirect_to admin_testimonials_path
    else
      render :action => 'new'
    end
  end  

  def edit
    @testimonial = Testimonial.find(params[:id])
  end  

  def update
    @testimonial = Testimonial.find(params[:id])
    if @testimonial.update_attributes(params[:testimonial])
      flash[:notice] = "Successfully updated Testimonial."
      redirect_to admin_testimonials_path
    else
      render :action => 'edit'
    end
  end  

  def order
    params[:draggable].each_with_index do |id, index|
      Testimonial.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end  

  def destroy
    @testimonial = Testimonial.find(params[:id])
    @testimonial.destroy
    flash[:notice] = "Successfully destroyed Testimonial."
    redirect_to admin_testimonials_path
  end
  
end
