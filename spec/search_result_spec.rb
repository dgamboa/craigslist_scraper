require_relative '../lib/search_result.rb'
require 'fakeweb'
require 'nokogiri'
require 'open-uri'

describe SearchResult do

  before(:each) do
    @search_result = SearchResult.new('http://sfbay.craigslist.org/search/?areaID=1&subAreaID=&query=futon&catAbb=sss')
  end

  context ".initialize" do

    it "sets a query date/time" do
      @search_result.query_date.day.should == Time.now.day
    end

    it "sets the query attribute to the search url" do
      @search_result.query.should == 'http://sfbay.craigslist.org/search/?areaID=1&subAreaID=&query=futon&catAbb=sss'
    end

    it "creates an empty results array" do
      @search_result.list.should == []
    end

    it "calls #new_posts" do
      SearchResult.any_instance.should_receive(:new_posts)
      SearchResult.new('http://sfbay.craigslist.org/search/?areaID=1&subAreaID=&query=futon&catAbb=sss')
    end

  end

  context "#new_posts" do

    it "calls #parsed_search" do
      SearchResult.any_instance.should_receive(:parsed_search)
      SearchResult.new('http://sfbay.craigslist.org/search/?areaID=1&subAreaID=&query=futon&catAbb=sss')
    end

  end

  context "#parsed_search" do

    before(:each) do
      @data = Nokogiri::HTML(open('http://sfbay.craigslist.org/search/?areaID=1&subAreaID=&query=futon&catAbb=sss'))

      # @html = Net::HTTP.get(URI.parse('http://sfbay.craigslist.org/search/?areaID=1&subAreaID=&query=futon&catAbb=sss'))
    #   FakeWeb.register_uri(:get, "http://sfbay.craigslist.org/search/?areaID=1&subAreaID=&query=futon&catAbb=sss")
    end

    it "returns a list of rows" do
      # @all_posts = @data.css('.row')
      @search_result.parsed_search.length.should == 100
    end

  end


end