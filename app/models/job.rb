class Job < ActiveRecord::Base

  acts_as_eskimagical

  named_scope :position,     :order => "jobs.position"
  named_scope :active,       lambda{{:conditions => ["jobs.recycled = ? AND jobs.display = ? AND jobs.closing_date > ?", false, true, Date.today]}}
  named_scope :recycled,     :conditions => ["jobs.recycled = ?", true]
  named_scope :unrecycled,   :conditions => ["jobs.recycled = ?", false]
  named_scope :order,        :order => "jobs.closing_date"
  named_scope :site_search, lambda{|search_term| {
    :conditions => [ "name LIKE :search OR summary LIKE :search", {:search => "%#{search_term}%"} ]
  } }
  named_scope :in_office, lambda{|office_ids| { :joins => :offices, :conditions => ["offices.id IN (?)", office_ids] }}
  named_scope :job_id_not, lambda{|job_id| { :conditions => ["jobs.id != ?", job_id] }}

  has_attached_document :application_pack
  has_documents

  validates_presence_of :name, :summary, :closing_date

  has_and_belongs_to_many :offices

  def active?
    display? && !recycled? && closing_date > Date.today
  end

  # each model should have a name method, if name is not in the db and a summary method, if summary is not in the db
  # this is used for searching the models

  # if you want to tweak the searching for a model define search_string_1, search_string_2 and search_string_3
  # these default to name, summary and attributes, higher number, higher in the search

end
