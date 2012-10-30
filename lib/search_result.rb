require 'sqlite3'
require 'nokogiri'
require 'open-uri'
require_relative './post.rb'

class SearchResult

  attr_reader :query_date, :query, :list

  def initialize(query)
    @query_date = Time.now
    @query = query
    @list = []
    @all_posts
    new_posts
  end

  private

  def new_posts
    parsed_search.each { |link| @list << Post.new(link) }
  end

  def parsed_search
    data = Nokogiri::HTML(open(@query))
    link_list = data.css('.row').map { |post| post.at_css('a')['href'] }
  end

end


search_result = SearchResult.new(ARGV[0])
puts search_result.list.last
#the instructions say that the command line command should
#return a nokogiri object (i.e. our 'data' variable).
#this command works (commenting out 'Post.new'), but the example command line argument is 'clist_scraper'.
#We may need to make a separate class for the command line.  I like our way better though.