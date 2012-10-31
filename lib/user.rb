require 'time'
require_relative './search_result'

class User

  attr_reader :name, :email

  def initialize(name, email)
    @name = name
    @email = email
    session
  end

  def save
    db = SQLite3::Database.new("craigslist_scraper.db")
    db.execute("insert into users (name, email, created_at) values ( ?, ?, ? )", @name, @email, Time.now.to_s)
  end

  def session
    while true
      user = gets.chomp
      Result.new(query, user_id)
    end
  end

end


user = User.new("Joe", "joe@phys.edu")
user.save
# search_result = Result.new(1, ARGV[0])