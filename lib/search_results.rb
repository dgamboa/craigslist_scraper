require 'sqlite3'
require 'nokogiri'
require 'fakeweb'

class SearchResult

  attr_reader :query_date

  def initialize(query)
    @query_date = Time.now
  end

end