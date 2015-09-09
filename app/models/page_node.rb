class PageNode < ActiveRecord::Base

  before_create {|node| node.layout = node.likely_layout}
  before_save {|node| node.page_contents.each{|x| x.process_images} }

  named_scope :active, :conditions => ["page_nodes.recycled = ? AND page_nodes.display = ?", false, true]
  named_scope :recycled, :conditions => ["recycled = ?", true]
  named_scope :unrecycled, :conditions => ["page_nodes.recycled = ?", false]
  named_scope :roots, :conditions => {:parent_id => nil}
  named_scope :position, :order => "position"
  named_scope :controller_action, lambda { |c, a| { :conditions => ["controller = ? AND action = ?", c, a] } }
  named_scope :controller, lambda { |c| { :conditions => ["controller = ?", c] } }
  named_scope :models, :conditions => "model IS NOT NULL AND model != ''"
  named_scope :navigation, :conditions => {:display_in_navigation => true, :display => true}
  named_scope :can_have_children, :conditions => {:can_have_children => true}
  named_scope :can_be_deleted_or_edited, :conditions => ["can_be_deleted = ? OR can_be_edited = ?", true, true]
  named_scope :services, :conditions => ["parent_id = ?", 9]
  named_scope :children, lambda {|parent_id| { :conditions => ["parent_id = ?", parent_id] } }

  named_scope :button, :conditions => "page_contents.button_image_file_name IS NOT NULL", :include => :page_contents

  # if the names of the main 2 page nodes change this method will need to change too
  # the others shouldn't as they cascade off the same data
  scope_procedure :family_node, lambda { name_like("Services for you and your family") }
  scope_procedure :business_node, lambda { name_like("Services for your business") }
  scope_procedure :offices_node, lambda { name_like("Offices") }
  scope_procedure :about_us_node, lambda { name_like("About Us") }

  named_scope :service_nodes, lambda { { :conditions => ["id = ? OR id = ?", PageNode.family_node.first.id, PageNode.business_node.first.id] } }
  named_scope :contact_us_nodes, lambda{{:conditions => ["parent_id = ? OR parent_id = ?", PageNode.family_node.first.id, PageNode.business_node.first.id]}}
  scope_procedure :business_nodes, lambda {parent_id_equals(PageNode.business_node.first.id) }
  scope_procedure :family_nodes, lambda {parent_id_equals(PageNode.family_node.first.id) }

  has_friendly_id :url

  acts_as_eskimagical :recycle => true
  acts_as_tree :order => "position"
  has_and_belongs_to_many :team_members
  has_many :page_contents, :dependent => :destroy
  accepts_nested_attributes_for :page_contents

  validates_presence_of :name
  validates_uniqueness_of :name, :message => "must be unique"
  validates_format_of :name, :with => /^[\w\d\- ]+$/
  validates_uniqueness_of :url

  before_validation :set_url

  def set_url
    self.url = name.downcase.gsub(' ','-')
  end

  def self.contact_us
    self.name_like("Contact Us").first
  end

  # START SITE SPECIFIC
  #

  def self.all_service_nodes
    service_nodes = self.service_nodes
    pages = []
    for page in self.all
      for node in service_nodes
        if page.ancestors.include?(node)
          pages << page
          break
        end
      end
    end
    pages
  end

  def short_name
    length = 18
    if name.length > length
      "#{name[0..length-1]}..."
    else
      name
    end
  end

  #
  # END SITE SPECIFIC

  # each model should have a name method, if name is not in the db and a summary method, if summary is not in the db
  # this is used for searching the models

  # if you want to tweak the searching for a model define search_string_1, search_string_2 and search_string_3
  # these default to name, summary and attributes, higher number, higher in the search

  def sections
    page_nodes = []
    page_node = self.parent
    while page_node
      page_nodes << page_node
      page_node = page_node.parent
    end
    page_nodes.reverse
  end

  def sections_string
    sections.collect{|s| s.name}.join(" / ")
  end

  def sections_name
    (sections.collect{|s| s.name} << self.name).join(" / ")
  end

  def is_a_link?
    (layout == "link") ? true : false
  end

  def path
    if controller? && action?
      {:controller => "/" + controller, :action => action}
    elsif controller?
      {:controller => "/" + controller}
    else
      if !active_content.main_content? && children.length > 0
        children.sort_by{|x| x.position}.first.path
      else
        self
      end
    end
  end

  def admin_path
    if controller? && !action?
      {:controller => "admin/#{controller}"}
    else
      {:controller => "admin/page_nodes", :action => "edit", :id => self.id}
    end
  end

  def active_content
    if page_contents.length > 1
      page_contents.select{|x| x.active?}.first || page_contents.first
    elsif page_contents.length == 1
      page_contents.first
    else
      page_contents.build(:active => false)
    end
  end

  def linked_active_content
    if layout == "link"
      node = PageNode.find_by_url(active_content.main_content.gsub("/page/", ""))
      if node
        return node.active_content
      end
    end
    nil
  end

  def navigation_title
    if active_content && active_content.navigation_title?
      active_content.navigation_title
    else
      name
    end
  end

  def title
    if active_content && active_content.title
      active_content.title
    else
      name
    end
  end

  def style
    return stylesheet if stylesheet?
    page_node = parent
    while page_node != nil do
      return page_node.stylesheet if page_node.stylesheet?
      page_node = page_node.parent
    end
    return nil
  end

  def css_class
    style.gsub("webstyle_","").gsub(".css","")
  end

  def likely_layout
    page_node = self
    while page_node != nil do
      #puts page_node.title
      return page_node.layout if page_node.layout?
      page_node = page_node.parent
    end
    return "basic"
  end

  def active?
    display? && display_in_navigation
  end

end
