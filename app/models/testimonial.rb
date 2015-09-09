class Testimonial < ActiveRecord::Base

  include ApplicationHelper

  acts_as_eskimagical
  acts_as_taggable_on :tags

  has_and_belongs_to_many :team_members

  validates_presence_of :quote

  named_scope :position, :order => "position"
  named_scope :active, :conditions => ["recycled = ? AND display = ?", false, true]
  named_scope :recycled, :conditions => ["recycled = ?", true]
  named_scope :unrecycled, :conditions => ["recycled = ?", false]
  named_scope :site_search, lambda{|search_term| {
    :conditions => [ "quote LIKE :search OR author LIKE :search", {:search => "%#{search_term}%"} ]
  } }

  def active?
    display? && !recycled?
  end

  def name
    author
  end

  def summary
    quote
  end

  def children
    []
  end

  def long_name
    "#{author} - #{shorten quote, 40}"
  end

end
