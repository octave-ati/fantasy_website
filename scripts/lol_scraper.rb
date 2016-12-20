require 'open-uri'
require 'nokogiri'

# Scrape data from the leaguegraphs website using data from the LOL API
doc = Nokogiri::HTML(open("http://www.leagueofgraphs.com/lcs/lcs-schedule"))
table = doc.css('#lcsGamesTable')

# Defining left and right teams, expected result is "Team name"
teams_left = table.css('td.text-left.lcsTeam > a > div.img-align-block > div.txt.hide-for-small-down > span').map{|x| x.text.strip}
teams_right = table.css('td.text-right.lcsTeam > a > div.img-align-block-right > div.txt.hide-for-small-down > span').map{|x| x.text.strip}

# Exploiting match results, first query gives us an unordered result in the form of "2-3"
match_results = table.css('td.lcsMatchScoreColumn > div.spoiler').map{|x| x.text.strip}

# Extracting left and right score, and turning them into integers
left_score = []
right_score = []
match_results.each do |m|
  left_score << m.scan(/\d/)[0].to_i
  right_score << m.scan(/\d/)[1].to_i
end