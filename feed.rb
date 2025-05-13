require 'rss'
require 'open-uri'

url = 'https://anchor.fm/s/bb989624/podcast/rss'

URI.open(url) do |rss|
  feed = RSS::Parser.parse(rss)
  puts "Title: #{feed.channel}"

  feed.items.each do |item|
    puts "Item: #{item.title}"
  end

end

