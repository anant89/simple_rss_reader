module FeedsHelper
def sort_key gradesm
@grades_keys = gradesm.keys.sort.reverse.paginate(:page => params[:page],:per_page => 5)

end

def getting_feed feeditem
           rss = RSS::Parser.parse(open(feeditem.feed_url).read, false)
              if params[:action] == 'feed'
               @title = rss.channel.title
              end
	      rss.items.take(10).each do |i|
               @gradesm[i.date]= [i.title,i.link,i.description]
	      end
end
end
