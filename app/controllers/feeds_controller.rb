class FeedsController < ApplicationController
require 'rss'
require 'nokogiri'
require 'will_paginate/array'
def reader_page
    @feeds = Feed.all
       getting_feed
	respond_to do |format|
      format.html # index.html.erb
      format.js
    end
	
  end
def getting_feed

@gradesm = Hash.new
	@feeds.each do |feed| 
	    rss = RSS::Parser.parse(open(feed.feed_url).read, false)
	      rss.items.take(10).each do |i|
           @gradesm[i.date]= [i.title,i.link,i.description]
           end 
	end
	
	@grades_keys = @gradesm.keys.sort.reverse.paginate(:page => params[:page],:per_page => 5)
end

# get title of particular feed
def feed
    @feed = Feed.find(params[:id])
	
@gradesm = Hash.new
	
	    rss = RSS::Parser.parse(open(@feed.feed_url).read, false)
           @title = rss.channel.title
	      rss.items.take(10).each do |i|
       
@gradesm[i.date]= [i.title,i.link,i.description]
           end 
@grades_keys = @gradesm.keys.sort.reverse.paginate(:page => params[:page],:per_page => 5)
	respond_to do |format|
      format.html # index.html.erb
      format.js
    end
end
end
