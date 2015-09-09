class Office < ActiveRecord::Base
	
	acts_as_eskimagical
  
	named_scope :position, :order => "position"
  named_scope :active, :conditions => ["recycled = ? AND display = ?", false, true]
  named_scope :recycled, :conditions => ["recycled = ?", true]
  named_scope :unrecycled, :conditions => ["recycled = ?", false]
  named_scope :arrange, :order => "name"
  named_scope :site_search, lambda{|search_term| {
    :conditions => [ "name LIKE :search OR address LIKE :search", {:search => "%#{search_term}%"} ]
  } }
  
  has_attached_image :image, :styles => {:list => "122x65#"}
  has_images
  may_contain_images [:directions]
  
  has_and_belongs_to_many :jobs
  
  def active?
  	display? && !recycled?
  end
  
  def full_address
    address + "\r" + postcode
  end
  
end
