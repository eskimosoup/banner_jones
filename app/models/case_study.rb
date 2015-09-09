class CaseStudy < ActiveRecord::Base
	
  acts_as_eskimagical
	acts_as_taggable_on :tags
  
	named_scope :position, :order => "position"
  named_scope :active, :conditions => ["recycled = ? AND display = ?", false, true]
  named_scope :recycled, :conditions => ["recycled = ?", true]
  named_scope :unrecycled, :conditions => ["recycled = ?", false]
  named_scope :site_search, lambda{|search_term| {
    :conditions => [ "name LIKE :search OR summary LIKE :search", {:search => "%#{search_term}%"} ]
  } }
  
  has_attached_image :image, :styles => {:index => "80x80#", :show => "200"}
  has_images
  
  may_contain_images :main_content
  
  def active?
  	display? && !recycled?
  end
  
  
  
end
