class LegalAidRequest < ActiveRecord::Base

  acts_as_eskimagical

  after_create :contact

  named_scope :position, :order => "position"
  named_scope :active, :conditions => ["recycled = ? AND display = ?", false, true]
  named_scope :recycled, :conditions => ["recycled = ?", true]
  named_scope :unrecycled, :conditions => ["recycled = ?", false]

  validates_presence_of :name
  validates_presence_of :email, :if => Proc.new{|x| x.phone.blank? }
  validates_presence_of :phone, :if => Proc.new{|x| x.email.blank? }

  def active?
    display? && !recycled?
  end

  # each model should have a name method, if name is not in the db and a summary method, if summary is not in the db
  # this is used for searching the models

  # if you want to tweak the searching for a model define search_string_1, search_string_2 and search_string_3
  # these default to name, summary and attributes, higher number, higher in the search

  def total_income
    ret = 0
    ret += gross_income if gross_income
    ret += other_income if other_income
    ret += benefits_income if benefits_income
    return ret
  end

  def total_outgoings
    ret = 0
    ret -= (children_out * 285) if children_out
    ret -= (children_out == 0 && rent_out > 545) ? 545 : rent_out if rent_out
    ret -= (people_out * 45) if people_out
    ret -= 175 if partner_out
    ret -= maintenance_out if maintenance_out
    ret -= childcare_out if childcare_out
    ret -= tax_out if tax_out
    return ret
  end

  def disposable_income
    total_income + total_outgoings
  end

  def saving_total
    ret = 0
    ret += savings if savings
    ret += shares if shares
    ret += property if property
    ret += bonds if bonds
    ret += endowment if endowment
    return ret
  end

  def contact
    Mailer.deliver_lar(self)
  end

  def approved?
    return true if benefits?
    return false if total_income > 2657
    return false if (total_income + total_outgoings) > 2700
    return false if high_equity
    return false if saving_total > 8000
    return false if (saving_total <= 0 and high_equity == false)


    return true
  end

end
