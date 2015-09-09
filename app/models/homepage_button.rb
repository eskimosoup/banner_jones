class HomepageButton < ActiveRecord::Base

  acts_as_eskimagical

  named_scope :position, :order => "position"
  named_scope :active, :conditions => ["recycled = ? AND display = ?", false, true]
  named_scope :recycled, :conditions => ["recycled = ?", true]
  named_scope :unrecycled, :conditions => ["recycled = ?", false]

  validates_format_of :external_link,
                      :with => /^((http|ftp|https?):\/\/((?:[-a-z0-9]+\.)+[a-z]{2,}))/,
                      :if => Proc.new{|x| x.external_link?}

  has_attached_image :image, :styles => {:button => "600x138#"}
  has_images

  def active?
    display? && !recycled?
  end

  def self.get(number)
    number = number - 1
    HomepageButton.all[number] || HomepageButton.create!
  end

end
