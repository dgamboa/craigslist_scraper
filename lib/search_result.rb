require 'sqlite3'
require 'nokogiri'
require 'fakeweb'

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
    all_posts = data.css('.row')
    all_posts.css('a').select {|link| link['href'].length > 10}.map { |link| link['href'] }
  end

end

class Post
end