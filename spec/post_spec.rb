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
end #/END describe post


