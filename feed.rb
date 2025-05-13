#Todo 
#When finding episode 2, it pulls first item which includes the number 2 
#Some RSS feeds don't work, some episode numbers aren't in the title
#Episode numbers are in <itunes:episode>, but can't retrieve with feed.channel.items[0]["itunes:episode"]

#EXAMPLE URLs 
#url = 'https://anchor.fm/s/bb989624/podcast/rss'
#url = 'https://feeds.megaphone.fm/gamescoop'

require 'rss'
require 'open-uri'

feed = ''
episode_request = 0 
episode_number = 0 

def podcast_title(feed, episode_number = 0)
  puts "The latest episode of #{feed.channel.title} is: #{feed.channel.items[episode_number].title}" 
end

#Only displays first 16 characters of publish date 
def podcast_publish_date(feed, episode_number = 0)
  puts "This episode published on: #{feed.channel.items[episode_number].pubDate.to_s[0..15]}" 
end

#Protection for if a link isn't in RSS feed
def podcast_link(feed, episode_number = 0)
  if feed.channel.items[episode_number].link == nil 
    puts "No link was provided from feed" 
  else 
    puts "Link to episode: #{feed.channel.items[episode_number].link}"
  end
end

def podcast_episode(feed, episode_number = 0)
  podcast_title(feed, episode_number)
  podcast_publish_date(feed, episode_number)
  podcast_link(feed, episode_number)  
end

#When user types in episode number, search through array to find the episode index 
def episode_index(feed, episode_number)
  feed.channel.items.each_with_index do |item, index|
    if item.title.include? episode_number.to_s 
       return index 
    end
  end
end

#Asks user to provide RSS feed 
puts "Please type URL for podcast RSS feed"
url = gets.chomp!

#If URL is invalid, output error message
begin
      URI.open(url) { |rss| feed = RSS::Parser.parse(rss) }
rescue
      puts "Invalid RSS-URL, please run program again"
      exit(1)
end 
     #puts feed #Testing purposes 
     podcast_episode(feed, episode_number)

    #Asks user to search for a specific episode number, wrapped in while loop to catch invalid entries 
    #Probably a cleaner way to do this, involves a lot of repeating code
    while episode_request < 1 || episode_request > (feed.channel.items.size - 1)
          puts "Type in an episode you want to find. #{feed.channel.title} currently has #{feed.channel.items.size - 1} episodes"
          episode_request = gets.chomp!.to_i
      
      if episode_request < 1 || episode_request > (feed.channel.items.size - 1)
          puts "Invalid number, please enter an integer starting from 1 to #{feed.channel.items.size - 1}. Try again"
      else 
          puts "Thanks, searching for epsiode number: #{episode_request}"
      end
    end

    episode_number = episode_index(feed, episode_request)
    podcast_episode(feed, episode_number)

