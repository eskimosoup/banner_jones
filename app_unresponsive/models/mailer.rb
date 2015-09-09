class Mailer < ActionMailer::Base
	
	add_template_helper ApplicationHelper
  
	def contact_us(title, name, email, tel, pcm, enquiry, department, heard_about)
    @completed_by       = name.blank? ? ("Someone") : (title.blank? ? name : title + " " + name)
    @subject            = "Contact Us Form Completed by #{@completed_by} - #{SiteSetting.like("Site Name").first.value}"
    @from               = SiteSetting.like("Email").first.value
    @recipients         = SiteSetting.like("Email").first.value
    @body[:enquiry]     = enquiry
    @body[:title]       = title
    @body[:name]        = name
    @body[:email]       = email
    @body[:tel]         = tel
    @body[:pcm]         = pcm
    @body[:department]  = department
    @body[:heard_about] = heard_about
    content_type "text/html"
  end
  
	def booking_request(event_name, name, email, phone, no_of_places, additional_names)
    @subject                 = "Booking Request Form Completed for \"#{event_name}\""
    @from                    = SiteSetting.like("Email").first.value
    @recipients              = SiteSetting.like("Email").first.value
    @body[:event_name]       = event_name
    @body[:name]             = name
    @body[:email]            = email
    @body[:phone]            = phone
    @body[:no_of_places]     = no_of_places
    @body[:additional_names] = additional_names
    content_type "text/html"
  end

	def conveyancing_quote_to_user(conveyancing_quote, html)
    @subject            = "Your Banner Jones Conveyancing Quote"
    @from               = SiteSetting.like("Email").first.value
    @recipients         = conveyancing_quote.email
    c = Curl::Easy.perform(html)
    part(:content_type => "text/html", :body => c.body_str)
    conveyancing_quote.generate_pdf(html)    
    attachment(:content_type => "application/mixed", :body => File.read(conveyancing_quote.pdf_path), :filename => "Your Banner Jones Conveyancing Quote.pdf")
  end
  
	def conveyancing_quote_to_admin(conveyancing_quote, html, state)
    @subject            = "Conveyancing Quote (ID #{conveyancing_quote.id}) - #{state}"
    @from               = SiteSetting.like("Email").first.value
    @recipients         = SiteSetting.like("Conveyancing Email").first.value
    c = Curl::Easy.perform(html)
    part(:content_type => "text/html", :body => c.body_str)
    conveyancing_quote.generate_pdf(html)    
    attachment(:content_type => "application/mixed", :body => File.read(conveyancing_quote.pdf_path), :filename => "Your Banner Jones Conveyancing Quote.pdf")
  end
  
  def lar(lar)
    @subject           = "New Legal Aid Request (#{lar.name})"
    @from              = lar.email || SiteSetting.like("Email").first.value      
    @recipients        = SiteSetting.like("Legal Aid Request Email").first.value
    @body[:lar]   = lar
    content_type "text/html"  
  end
  
end
