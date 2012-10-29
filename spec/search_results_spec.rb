require './search_results'

describe SearchResult do

  before(:each) do
    @search_result = SearchResult.new('http://sfbay.craigslist.org/search/?areaID=1&subAreaID=&query=futon&catAbb=sss')
  end

  it "sets a query date/time" do
    # Time.stub(:now).and_return('2012-10-29 16:36:00')
    @search_result.query_date.day.should == Time.now.day
  end

end