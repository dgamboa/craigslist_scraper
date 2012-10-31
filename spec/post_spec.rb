require_relative "../lib/post.rb"

describe Post do
    let(:my_post) {Post.new('http://sfbay.craigslist.org/eby/apa/3312534802.html')}

  context "initialize" do
    it "creates a Post class" do
      lambda {  my_post }.should_not raise_error
    end
  end

  context '#date_posted' do
    it 'returns a date' do
      my_post.date_posted.should include ("Date")
    end
  end

  context "#title" do
    it "includes a text title" do
      my_post.title.should be_instance_of(String)
    end
  end

  context '#price' do
    it 'returns a dollar value' do
     my_post.price.should include ('$')
    end
  end

  context '#location' do
    it 'returns a location' do
     my_post.location.should include ('hercules, pinole, san pablo, el sob')
    end
  end

  context '#category' do
    it 'returns a category of apts/housing for rent' do
     my_post.category.should include ('apts/housing for rent')
    end
  end

  context '#save' do

    after(:each) do
      db = SQLite3::Database.new("craigslist_scraper.db")
      db.execute("delete from posts where url = 'http://sfbay.craigslist.org/eby/apa/3312534802.html'")
    end

    it "saves the post to a database" do
      db = SQLite3::Database.new("craigslist_scraper.db")
      my_post.save(1)
      db.execute("select title from posts where url = 'http://sfbay.craigslist.org/eby/apa/3312534802.html'").should == [['San Pablo Home - Remodeled']]
    end
  end

end #/END describe post


