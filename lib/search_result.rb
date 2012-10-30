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
    link_list = data.css('.row').map { |post| post.at_css('a') }
  end

end

class Post
end