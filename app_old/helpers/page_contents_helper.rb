module PageContentsHelper

  def basic
    tags = @page_node.active_content.subscriptions.map{|x| x.name}
    @articles = Article.active.tagged_with(tags, :any => true).first(6)
    @faqs = Faq.active.tagged_with(tags, :any => true).first(6)
    @case_studies = CaseStudy.active.tagged_with(tags, :any => true).first(4)
    @testimonials = Testimonial.active.tagged_with(tags, :any => true).first(4)
    @team_members = @page_node.team_members
    @team_cats = TeamMember.find(:all, :conditions => ["team_catagory = ?", "#{@page_node.name}"])
  end
  
  def link
    redirect_to @page_node.active_content.main_content
  end
  
  def service
    basic
  end
  
  def none
    
  end

  def service_quote
    basic
  end

  def family_assistance_calculator
    basic
  end

end
