require_relative '../lib/search_result'
require_relative '../lib/post'

describe "search_result.new" do

  it "creates a list of posts" do
    search_result = SearchResult.new('http://sfbay.craigslist.org/search/?areaID=1&subAreaID=&query=futon&catAbb=sss')
    search_result.list.last.should be_an_instance_of Post
  end

end