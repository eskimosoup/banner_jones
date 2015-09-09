class PageContent < ActiveRecord::Base

  subscribes_to :basic => [], :none => [], :service_quote => [Article, CaseStudy, Testimonial, Faq], :service => [Article, CaseStudy, Testimonial, Faq], :family_assistance_calculator => [Article, CaseStudy, Testimonial, Faq]

  has_attached_image :highlight_image, :styles => {:main => "208"}
  has_attached_image :highlight_2_image, :styles => {:main => "208"}
  has_attached_image :button_image, :styles => {:main => "600x138#", :small => "436x100#"}
  has_attached_image :banner_image, :styles => {:main => "545x328#"}
  has_images
  may_contain_images [:main_content, :highlight_content, :splash_content]

  named_scope :active, :conditions => "active = true"
  named_scope :site_search, lambda{|search_term| {
    :joins => :page_node,
    :conditions => [ "page_nodes.display = 1 AND (navigation_title LIKE :search OR title LIKE :search OR main_content LIKE :search)", {:search => "%#{search_term}%"} ]
  } }

  acts_as_eskimagical :recycle=> true

  belongs_to :page_node
  belongs_to :video

  validates_presence_of :title, :navigation_title
  validates_format_of :highlight_external_link,
                      :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix,
                      :if => Proc.new{|x| x.highlight_external_link? }

  before_validation :try_and_complete
  after_destroy :check_if_last

  # each model should have a name method, if name is not in the db and a summary method, if summary is not in the db
  # this is used for searching the models

  # if you want to tweak the searching for a model define search_string_1, search_string_2 and search_string_3
  # these default to name, summary and attributes, higher number, higher in the search

  def check_if_last
    if page_node.page_contents.length == 0
      page_node.destroy
    end
  end

  def activate
    page_node.page_contents.each{|pc| pc.update_attribute(:active, false)}
    self.update_attribute(:active, true)
  end

  def title
    if super.nil? || super.empty?
      page_node.name
    else
      super
    end
  end

  def name
    page_node.title if page_node
  end

  def summary
    require 'rubygems'
    require 'sanitize'
    Sanitize.clean(self.main_content)[0..600] if main_content
  end

  protected

  def try_and_complete
    self.url_title = title.gsub(/\s/,'_').gsub(/[^\w\d_]/, '').downcase if url_title.nil? || url_title.blank?
    self.navigation_title = title if navigation_title.nil? || navigation_title.blank?
  end

end
