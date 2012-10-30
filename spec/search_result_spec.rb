require_relative '../lib/search_result.rb'
require 'fakeweb'
require 'nokogiri'
require 'open-uri'

describe SearchResult do

  before(:each) do
    Post.stub(:new).and_return('post object')
    @search_result = SearchResult.new('http://sfbay.craigslist.org/search/?areaID=1&subAreaID=&query=futon&catAbb=sss')
  end

  context ".initialize" do

    it "sets a query date/time" do
      @search_result.query_date.day.should == Time.now.day
    end

    it "sets the query attribute to the search url" do
      @search_result.query.should == 'http://sfbay.craigslist.org/search/?areaID=1&subAreaID=&query=futon&catAbb=sss'
    end

    it "returns a list of Post objects" do
      @search_result.list.last.should == 'post object'
    end

  end

end