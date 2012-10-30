require 'sqlite3'
require 'active_record'

module Database

  def save_search_results
    ActiveRecord::Base.establish_connection(
      :adapter => 'sqlite3',
      :database => 'craigslist_scraper.db')

    search_result = Result.create(:query => @query, :count => @list.length)
    @list.each do |post|
      search_result.posts.create(:date_posted => post.date_posted, :title => post.title, :price => post.price, :location => post.location, :category => post.category, :url => post.url)
    end
  end
end

class Result < ActiveRecord::Base
  has_many :posts
end

class Post < ActiveRecord::Base
  belongs_to :results
end