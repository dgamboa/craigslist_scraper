require 'nokogiri'
require 'open-uri'

class Post
  attr_reader :post_url
  def initialize(post_url)
    @post_url = post_url
    @scraped_data = Nokogiri::HTML(open(@post_url))
  end

  def date_posted
    sanitized_data('.postingdate')
  end

  def posting_title
    sanitized_data('title')
  end

  def listing_price
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

private

  def sanitized_data(selector)
    @scraped_data.at_css(selector).text.strip
  end
end #/END Post class

my_post = Post.new('http://sfbay.craigslist.org/eby/apa/3312534802.html')
puts my_post.category
