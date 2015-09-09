ActionController::Routing::Routes.draw do |map|

  map.resources :payments, :collection => {:gateway_reply => [:get, :post]}
  map.resources :conveyancing_quotes, :only => [:new, :show, :index, :create], :collection => {:update_type_fields => :post}, :member => {:download_pdf => :get, :pdf_for => :get, :register_interest => :post}
  map.resources :jobs
  map.resources :team_categories
  map.resources :homepage_buttons
  map.resources :videos, :only => [:show, :index]
  map.resources :offices
  map.resources :home_highlights
  map.resources :home_highlights
  map.resources :team_members
  map.resources :faqs
  map.resources :case_studies
  map.resources :testimonials
  map.resources :events
  map.resources :blog_entries
  map.resources :articles
  map.resources :page_nodes, :as => "page", :member => {:splash => :get}
  map.resources :page_contents

  map.namespace :admin do |admin|

    admin.resources :legal_aid_requests, :only => [:index, :destroy, :edit, :update]
    admin.resources :conveyancing_quotes, :except => [:show, :new, :create], :member => {:close => :get, :reopen => :get}
    admin.resources :jobs, :except => [:show]
    admin.resources :team_categories, :except => [:show], :collection => {:order => :post}
    admin.resources :homepage_buttons, :except => [:show]
    admin.resources :videos, :except => [:show]
    admin.resources :offices, :except => [:show]
    admin.resources :home_highlights, :except => [:show]
    admin.resources :home_highlights, :except => [:show]
    admin.resources :team_members, :except => [:show], :collection => {:order => :post}
    admin.resources :faqs, :except => [:show]
    admin.resources :case_studies, :except => [:show]
    admin.resources :testimonials, :except => [:show]
    admin.resources :events, :except => [:show]
    admin.resources :blog_entries, :except => [:show]
    admin.resources :articles, :except => [:show]
  	admin.resources :page_nodes, :except => [:show],
  	                             :collection => {:index_list => :get,
  	                                             :index_reorder => :get}

    admin.resources :jargons, :except => [:show]

    admin.connect 'recycle_bin/index', :controller => 'recycle_bin', :action => 'index'

    admin.connect 'administrators/edit_self', :controller => 'administrators', :action => 'edit_self'

    # This route is not good and is what we are trying to move away from. It should be replaceable
    # when the new (as of October 2010) document uploader is finished and added to the site.
    admin.connect 'html_popups/:action', :controller => 'html_popups'
  end

  map.connect 'events/:id', :controller => 'events', :action => 'show'

  map.connect 'web/accessibility', :controller => 'web', :action => 'accessibility'
  map.connect 'web/contact_us', :controller => 'web', :action => 'contact_us'
  map.connect 'web/deliver_contact_us', :controller => 'web', :action => 'deliver_contact_us'
  map.connect 'web/index', :controller => 'web', :action => 'index'
  map.connect 'web/site_down', :controller => 'web', :action => 'site_down'
  map.connect 'web/wills_enquiry', :controller => 'web', :action => 'wills_enquiry'
  map.connect 'web/site_map', :controller => 'web', :action => 'sitemap'
  map.connect 'web/site_search', :controller => 'web', :action => 'site_search'
  map.connect 'web/thank_you', :controller => 'web', :action => 'thank_you'
  map.family_assistance '/family_assistance', :controller => 'web', :action => 'family_assistance'
  map.sitemap '/sitemap.:format', :controller => 'web', :action => 'sitemap'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.root :controller => "web", :action => "index"
end
