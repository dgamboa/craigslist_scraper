require 'nokogiri'
require 'open-uri'
require 'sqlite3'

class Post
  attr_reader :post_url

  def initialize(post_url)
    @url = post_url
    @scraped_data = Nokogiri::HTML(open(@url))
  end

  def date_posted
    sanitized_data('.postingdate')
  end

  def title
    sanitized_data('title')
  end

  def price
    sanitized_data('h2').match(/\$\d+/).to_s
  end

  def location
    h2_string = sanitized_data('h2')
    h2_string.match(/\(.+\)\z/).to_s
    h2_string.gsub("(", "")
    h2_string.gsub(")", "")
  end

  def category
    @scraped_data.at_css('.bchead').last_element_child.content
  end

  def save(result_id)
    db = SQLite3::Database.new("craigslist_scraper.db")
    db.execute("insert into posts (date_posted, title, price, location, category, url, created_at, result_id) values
    ( ?, ?, ?, ?, ?, ?, ?, ?)", date_posted, title, price, location, category, @url, Time.now.to_s, result_id)
  end

  private

  def sanitized_data(selector)
    @scraped_data.at_css(selector).text.strip
  end

end #/END Post class