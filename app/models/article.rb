class Article < ActiveRecord::Base

  acts_as_eskimagical
  acts_as_taggable_on :tags

  validates_presence_of :headline, :date
  validates_uniqueness_of :main_content

  named_scope :position, :order => "position"
  named_scope :active, lambda{ {:conditions => ["recycled = ? AND display = ? AND date <= ?", false, true, Date.today], :order => "date DESC" }}
  named_scope :recycled, :conditions => ["recycled = ?", true]
  named_scope :unrecycled, :conditions => ["recycled = ?", false]
  named_scope :year, lambda{|year| {:conditions => ["year(date) = ?", year]} }
  named_scope :month, lambda{|month| {:conditions => ["month(date) = ?", month]} }
  named_scope :site_search, lambda{|search_term| {
    :conditions => [ "headline LIKE :search OR summary LIKE :search", {:search => "%#{search_term}%"} ]
  } }

  has_attached_image :image, :styles => {:index => "208", :show => "200"}
  has_images

  may_contain_images :main_content

  def active?
    display? && !recycled? && date <= Date.today
  end

  def name
    headline
  end

  def self.years
    self.active.collect{|a| a.date.year}.uniq.sort
  end

  def self.months(year)
    self.active.year(year).collect{|a| a.date.month}.uniq.sort
  end

  def self.latest(count=1)
    if count > 1
      self.active[0..(count-1)]
    else
      self.active.first
    end
  end

  def self.populate!
    require 'rubygems'
    require 'simple-rss'
    require 'open-uri'
    feed = 'http://feeds.bhpinfosolutions.co.uk/category/Legal-News/feed/'
    rss = SimpleRSS.parse open(feed)

    puts "parsing: #{feed}"

    rss.entries.each do |entry|
      article = Article.new
      article.source = feed
      article.headline = entry.title
      article.summary = entry.description
      article.main_content = entry.content_encoded
      article.date = entry.pubDate
      article.display = true
      article.tag_list = "Legal Updates"
      if article.save
        puts "saved: #{article.headline}"
      end
    end

    puts "done"

  end


end
