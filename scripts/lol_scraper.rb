require 'open-uri'
require 'nokogiri'

# Scrape data from the leaguegraphs website using the LOL API
doc = Nokogiri::HTML(open("http://www.leagueofgraphs.com/lcs/lcs-schedule"))
table = doc.css('#lcsGamesTable')

# Defining left and right teams, expected result is "Team name"
teams_left = table.css('td.text-left.lcsTeam > a > div.img-align-block > div.txt.hide-for-small-down > span').map{|x| x.text.strip}
teams_right = table.css('td.text-right.lcsTeam > a > div.img-align-block-right > div.txt.hide-for-small-down > span').map{|x| x.text.strip}

# Creating a list of unique teams
teams = (teams_left + teams_right).uniq

# Exploiting match results, first query gives us an unordered result in the form of "2-3"
match_results = table.css('td.lcsMatchScoreColumn > div.spoiler').map{|x| x.text.strip}

# Extracting left and right score, and turning them into integers
left_score = []
right_score = []
match_results.each do |m|
  left_score << m.scan(/\d/)[0].to_i
  right_score << m.scan(/\d/)[1].to_i
end

# Extracting timestamp, before using the script, I made sure each div.matchDate has a "data-timestamp-time" attribute
# Timestamp is also converted into an integer for direct database handling
datetime = table.css('td.lcsMatchScoreColumn > div.matchDate').map{|x| x.attributes["data-timestamp-time"].value.to_i}

# Extracting league name, made sure the elements existed, same as timestamp
league = table.css('td.dayInfosColumn > a > div.img-align-block > div > img').map{|x| x.attributes["title"].value}

@game_id = Game.find_by(name: "lol").id

teams.each do |t|
  Team.create!(name: t, game_id: @game_id)
end

datetime.each do |t|
  Match.create!(game_id: @game_id, timestamp: t)
end

while i < teams_left.length
  TeamMatch.create!(match_id: Match.find_by(timestamp: datetime[i]).id , team_id: Team.find_by(name: teams_left[i]).id , score: left_score[i], datetime: datetime[i])
  TeamMatch.create!(match_id: Match.find_by(timestamp: datetime[i]).id , team_id: Team.find_by(name: teams_right[i]).id , score: right_score[i], datetime: datetime[i])
end