require 'rss'
require 'open-uri'

url = 'https://anchor.fm/s/bb989624/podcast/rss'

URI.open(url) do |rss|
  feed = RSS::Parser.parse(rss)
 # puts "Title: #{feed.channel.title}"

 # puts "Episode: #{feed.items[0].title}"
  puts feed.channel.items[0].title 
  puts feed.channel.items[0].pubDate 
  puts feed.channel.items[0].link 
  
end



