class Payment < ActiveRecord::Base

	acts_as_eskimagical

	serialize :gateway_reply

	validates_presence_of :invoice_number, :company_name, :contact_number
	validates_format_of :amount, :with => /^\d+(\.\d{1,2})?$/

	before_create :generate_code

	def generate_code
	  self.code = Payment.generate_code
	end

	named_scope :position, :order => "position"
  named_scope :active, :conditions => ["recycled = ? AND display = ?", false, true]
  named_scope :recycled, :conditions => ["recycled = ?", true]
  named_scope :unrecycled, :conditions => ["recycled = ?", false]

  def self.generate_code(length=20)
    o =  [('a'..'z'),('A'..'Z'),(0..10)].map{|i| i.to_a}.flatten;
    return (0..length-1).map{ o[rand(o.length)]  }.join;
  end

  def active?
  	display? && !recycled?
  end

  HUMANIZED_ATTRIBUTES = {
    :invoice_number => "Reference number",
    :company_name => "Name"
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  def amount_with_extra
    amount.to_f * 1.022
  end

end
