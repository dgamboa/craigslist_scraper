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
    @all_posts = parsed_search
  end

  def parsed_search
  end

end