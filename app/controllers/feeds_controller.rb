class FeedsController < ApplicationController
include FeedsHelper
require 'rss'
require 'nokogiri'
require 'will_paginate/array'
def reader_page
    @feeds = Feed.all
      @gradesm = Hash.new #hash to all the rss feed items
	@feeds.each do |feed|
          getting_feed feed  # helper method to get content of individuals rss feed
	end
          sort_key @gradesm  # helper method to sort all the rss feed post
	respond_to do |format|
           format.html # index.html.erb
           format.js
         end
	
  end

# get rss feeds of particular feed
def feed
    @feed = Feed.find(params[:id])
     @gradesm = Hash.new
        getting_feed @feed	   
        sort_key @gradesm	
      respond_to do |format|
      format.html # index.html.erb
      format.js
        end
end
end
