class ConveyancingQuote < ActiveRecord::Base

  VAT = 20
	
	acts_as_eskimagical
	
  validates_presence_of :title, :first_names, :last_name, :phone, :email, :conveyancing_type
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
	validates_numericality_of :purchase_amount, :greater_than => 0, :if => Proc.new{|x| x.purchase_amount? }
	validates_numericality_of :sale_amount, :greater_than => 0, :if => Proc.new{|x| x.sale_amount? }
	validates_numericality_of :remortgage_amount, :greater_than => 0, :if => Proc.new{|x| x.remortgage_amount? }
	validates_numericality_of :equity_amount, :greater_than => 0, :if => Proc.new{|x| x.equity_amount? }
		
	validate :check_amounts
	
	before_create  :set_costs
	before_create  :generate_passcode
	before_destroy :remove_files
	
	named_scope :position, :order => "position"
  named_scope :active, :conditions => ["recycled = ? AND display = ?", false, true]
  named_scope :recycled, :conditions => ["recycled = ?", true]
  named_scope :unrecycled, :conditions => ["recycled = ?", false]
  
  def generate_passcode
    require 'active_support/secure_random'
    self.passcode = ActiveSupport::SecureRandom.hex(16)
  end
  
  def remove_files
    FileUtils.rm_rf(self.pdf_folder)
  end
  
	def check_amounts
    case conveyancing_type
    when "1"  
      errors.add(:sale_amount, "can't be blank") if sale_amount.blank?
    when "2"
      errors.add(:purchase_amount, "can't be blank") if purchase_amount.blank?
    when "3"
      errors.add(:sale_amount, "can't be blank") if sale_amount.blank?
      errors.add(:purchase_amount, "can't be blank") if purchase_amount.blank?
    when "4"
      errors.add(:remortgate_amount, "can't be blank") if remortgage_amount.blank?
    when "5"
      errors.add(:remortgate_amount, "can't be blank") if remortgage_amount.blank?
      errors.add(:equity_amount, "can't be blank") if equity_amount.blank?
    when "6"
      errors.add(:equity_amount, "can't be blank") if equity_amount.blank?
    end
  end
  
  def set_costs
    case conveyancing_type
    when "1"  
      self.sale_fees = calculated_sale_fees
    when "2"
      self.purchase_fees = calculated_purchase_fees
      self.land_reg_fees = calculated_purchasing_land_reg_fees
      self.stamp_duty = calculated_stamp_duty
    when "3"
      self.sale_fees = calculated_sale_fees
      self.purchase_fees = calculated_purchase_fees
      self.land_reg_fees = calculated_purchasing_land_reg_fees
      self.stamp_duty = calculated_stamp_duty
    when "4"
      self.land_reg_fees = calculated_land_reg_fees
      self.fixed_fee = 300
    when "5"
      self.land_reg_fees = calculated_land_reg_fees
      self.fixed_fee = 350
    when "6"
      self.fixed_fee = 300
    when "7"
      self.fixed_fee = 325
    end
  end
  
  def calculated_sale_fees
    if sale_amount <= 100000
      375.00
    elsif sale_amount <= 200000
      400.00
    elsif sale_amount <= 300000
      450.00
    elsif sale_amount <= 400000
      500.00
    else
      550.00
    end
  end

  def calculated_purchase_fees
    if purchase_amount <= 100000
      400.00
    elsif purchase_amount <= 200000
      450.00
    elsif purchase_amount <= 300000
      500.00
    elsif purchase_amount <= 400000
      550.00
    elsif purchase_amount <= 500000
      600.00
    else
      650.00
    end
  end
  
  def calculated_land_reg_fees
    amount = remortgage_amount
    if amount <= 100000
      50.00
    elsif amount <= 200000
      70.00
    elsif amount <= 500000
      90.00
    elsif amount <= 1000000
      130.00
    else
      260.00
    end
  end
  
  def calculated_purchasing_land_reg_fees
    amount = purchase_amount
    if amount <= 50000
      50.00
    elsif amount <= 80000
      80.00
    elsif amount <= 100000
      130.00
    elsif amount <= 200000
      200.00
    elsif amount <= 500000
      280.00
    elsif amount <= 1000000
      550.00
    else
      920.00
    end  
  end
  
  def calculated_stamp_duty
    if purchase_amount <= 125000
      0
    elsif purchase_amount <= 250000
      ((purchase_amount/100.00) * 1.00).to_i
    elsif purchase_amount <= 500000
      ((purchase_amount/100.00) * 3.00).to_i
    else
      ((purchase_amount/100.00) * 4.00).to_i
    end
  end
  
  def active?
  	display? && !recycled?
  end

  def self.titles
    ["Mr","Mrs","Miss","Ms","Dr", "Sir", "The Right Hon"]
  end  
  
  def self.conveyancing_types
    [
      ["Sale","1"],
      ["Purchase","2"],
      ["Sale and Purchase","3"],
      ["Remortgage Only","4"],
      ["Remortgage with Transfer of Equity","5"],
      ["Transfer of Equity Only","6"],
      ["Equity Release","7"]
    ]
  end
  
  def self.conveyancing_types_to_form_partial(type)
    case type
      when "1"
        "sale"
      when "2"
        "purchase"
      when "3"
        "sale_and_purchase"
      when "4"
        "remortgage_only"
      when "5"
        "remortgage_with_transfer_of_equity"
      when "6"
        "transfer_of_equity_only"
      else
        "equity_release"
    end
  end
  
  def partial_name
    for type in ConveyancingQuote.conveyancing_types
      if type.last == conveyancing_type
        return type.first.downcase.gsub(/\W/, "_")
      end
    end
  end
  
  def form_partial
    if conveyancing_type
      "conveyancing_quotes/form/#{partial_name}"
    else
      nil
    end
  end
  
  def show_partial
    "conveyancing_quotes/show/#{partial_name}"
  end
  
  def self.dates
    ["Now", "This Month", "Next 3 Months", "Not Sure"]
  end
  
  def subtotal
    ret = 0
    ret += sale_fees if sale_fees
    ret += purchase_fees if purchase_fees
    ret += fixed_fee if fixed_fee
    return ret
  end
  
  def vat
   (subtotal/100.00) * VAT
  end
  
  def pdf_folder
    File.join(RAILS_ROOT, 'public', 'assets', 'quotes', self.id.to_s)
  end
  
  def pdf_path
    File.join(pdf_folder, 'quote.pdf')
  end
  
  def generate_pdf(html)
    FileUtils.mkpath(self.pdf_folder)
    pdf = PDFKit.new(html)
    pdf.to_file(pdf_path)
  end
  
  def total
    ret = 0
    ret += subtotal
    ret += vat    
    return ret
  end
  
end
