class Video < ActiveRecord::Base
	
	acts_as_eskimagical
  
	named_scope :position, :order => "position"
  named_scope :active, :conditions => ["recycled = ? AND display = ?", false, true]
  named_scope :recycled, :conditions => ["recycled = ?", true]
  named_scope :unrecycled, :conditions => ["recycled = ?", false]
  
  validates_format_of :youtube_url,
                      :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  validates_presence_of :name
  
  may_contain_images [:summary]
                    
  
  def active?
  	display? && !recycled?
  end
  
  def valid?
    youtube_id != nil
  end
  
  def youtube_id
    scan = youtube_url.scan(/v=([\d\w-]*)/i)
    if scan.first && scan.first.first
      scan.first.first
    else
      nil
    end    
  end
  
  def thumbnail_url
    "http://img.youtube.com/vi/#{youtube_id}/default.jpg"
  end
  
  def embed_code
  "<iframe title=\"YouTube video player\" class=\"youtube-player\" type=\"text/html\" width=\"457\" height=\"367\" src=\"http://www.youtube.com/embed/#{youtube_id}?wmode=opaque\" frameborder=\"0\" allowFullScreen></iframe>"
  end
    
  # each model should have a name method, if name is not in the db and a summary method, if summary is not in the db
  # this is used for searching the models
  
  # if you want to tweak the searching for a model define search_string_1, search_string_2 and search_string_3
  # these default to name, summary and attributes, higher number, higher in the search
  
  
end
