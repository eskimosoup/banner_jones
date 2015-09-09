#- PageContent
#- Article
#- Event
#- Job
#- TeamMember
#- Faq
#- Testimonial
#- Office
#- CaseStudy

class Search

  def self.site(search_term="")
    results = []
    results += PageContent.active.site_search(search_term)
    results += Article.active.site_search(search_term)
    results += Event.active.site_search(search_term)
    results += Job.active.site_search(search_term)
    results += TeamMember.active.site_search(search_term)
    results += Faq.active.site_search(search_term)
    results += Testimonial.active.site_search(search_term)
    results += Office.active.site_search(search_term)
    results += CaseStudy.active.site_search(search_term)
    results
  end
  
end
