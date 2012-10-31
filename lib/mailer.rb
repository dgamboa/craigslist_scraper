require 'action_mailer'
require 'sqlite3'

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
   :address   => "smtp.gmail.com",
   :port      => 587,
   :domain    => "domain.com.ar",
   :authentication => :plain,
   :user_name      => "dazed.n.confused.spambot@gmail.com",
   :password       => "foobarfoobar",
   :enable_starttls_auto => true
  }

  ActionMailer::Base.view_paths= File.dirname(__FILE__)

class Mailer < ActionMailer::Base
  def get_array
    db = SQLite3::Database.new( "craigslist_scraper.db" )
    #@results = []
    @results = db.execute( "SELECT * FROM posts LIMIT 10" ) #do |row|
      #@results << row
    #end
    db.close
    #@results.each {|row| puts row}
  end

  def daily_email
    get_array
          # @post_url = "http://foobar.net"
          # @posting_title = "omg melgibson"
          # @listing_price = "7 bagillion dollarz"
          # @location = "zimbabwe"
          # @date_posted = "tomorrow?"


    mail(   :to      => "wigginsmichaelc@gmail.com",
            :from    => "dazed.n.confused.spambot@gmail.com",
            :subject => "yo dee do",
            :body => "whaa from the spambot?") do |format|
                format.text
                format.html
            end
  end
end


email = Mailer.daily_email
puts email
email.deliver

# Mailer.get_array


