class Faq < ActiveRecord::Base

  include ApplicationHelper

  acts_as_eskimagical
  acts_as_taggable_on :tags

  named_scope :position, :order => "position"
  named_scope :active, :conditions => ["recycled = ? AND display = ?", false, true]
  named_scope :recycled, :conditions => ["recycled = ?", true]
  named_scope :unrecycled, :conditions => ["recycled = ?", false]
  named_scope :site_search, lambda{|search_term| {
    :conditions => [ "question LIKE :search OR answer LIKE :search", {:search => "%#{search_term}%"} ]
  } }

  def active?
    display? && !recycled?
  end

  def name
    question
  end

  def summary
    answer
  end

end
