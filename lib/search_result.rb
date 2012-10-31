require 'sqlite3'
require 'nokogiri'
require 'open-uri'
require 'time'
require_relative './post.rb'

class Result

  attr_reader :created_at, :query, :list

  def initialize(query)
    @query = query
    @list = new_posts
    @created_at = Time.now
    save
  end

  private

  def new_posts
    list = []
    parsed_search.each { |link| list << Post.new(link) }
    list
  end

  def parsed_search
    data = Nokogiri::HTML(open(@query))
    link_list = data.css('.row').map { |post| post.at_css('a')['href'] }
  end

  def save
    db = SQLite3::Database.new("craigslist_scraper.db")
    db.execute("insert into results (query, created_at) values ( ?, ? )", @query, @created_at.to_s )
    id = db.last_insert_row_id
    @list.each { |post| post.save(id) }
  end

end

#the instructions say that the command line command should
#return a nokogiri object (i.e. our 'data' variable).
#this command works (commenting out 'Post.new'), but the example command line argument is 'clist_scraper'.
#We may need to make a separate class for the command line.  I like our way better though.