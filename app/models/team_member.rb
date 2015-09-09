class TeamMember < ActiveRecord::Base

  acts_as_eskimagical

  has_and_belongs_to_many :page_nodes
  has_and_belongs_to_many :team_categories
  has_and_belongs_to_many :testimonials

  has_attached_image :image, :styles => {:index_page => "164x164#", :show_page => "130x195#"}
  has_attached_image :casual_image, :styles => {:original => "370x370>", :show_page => "370x370>"}
  has_attached_image :accred_1_image, :styles => {:show_page => "150"}
  has_attached_image :accred_2_image, :styles => {:show_page => "150"}
  has_attached_image :accred_3_image, :styles => {:show_page => "150"}
  has_images

  named_scope :position, :order => "position"
  named_scope :active, :conditions => ["team_members.recycled = ? AND team_members.display = ?", false, true]
  named_scope :recycled, :conditions => ["recycled = ?", true]
  named_scope :unrecycled, :conditions => ["recycled = ?", false]
  named_scope :site_search, lambda{|search_term| {
    :conditions => [ "name LIKE :search OR role LIKE :search OR office LIKE :search", {:search => "%#{search_term}%"} ]
  } }

  def self.team_catagories
    ['Services for you and your family', 'Services for your business']
  end

  def active?
    display? && !recycled?
  end

  # each model should have a name method, if name is not in the db and a summary method, if summary is not in the db
  # this is used for searching the models

  # if you want to tweak the searching for a model define search_string_1, search_string_2 and search_string_3
  # these default to name, summary and attributes, higher number, higher in the search

end
