require 'open-uri'
require 'nokogiri'
require 'date'

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

def datetime_conv(sec)
  Time.at(sec).to_datetime
end
# Extracting timestamp, before using the script, I made sure each div.matchDate has a "data-timestamp-time" attribute
# Timestamp is also converted into an integer for direct database handling
datetime = table.css('td.lcsMatchScoreColumn > div.matchDate').map{|x| datetime_conv(x.attributes["data-timestamp-time"].value.to_i/1000)}

# Extracting league name, made sure the elements existed, same as timestamp
league_acc = []
a = 0 
league = table.css('td.dayInfosColumn > a > div.img-align-block > div > img').map{|x| x.attributes["title"].value}
while a < league.length do
  if a > 6 && a < 12
    5.times do 
      league_acc << league[a]
    end
    
  elsif a > 6 && a < 15
  6.times do
    league_acc << league[a]
  end
  else
    league_acc << league[a]
  end
  a = a + 1 
end
league_list = league.uniq

@game_id = Game.find_by(name: "lol").id


# Begin a transaction to protect database entries from being partially created
ActiveRecord::Base.transaction do
  # teams.each do |t|
  #   Team.create!(name: t, game_id: @game_id)
  #   puts "Create team name #{t}"
  # end
  
  # datetime.each do |t|
  #   m = Match.create!(datetime: t, game_id: @game_id)
  #   puts "Create match id #{m.id}"
  # end
  
  # i = 0
  # while i < teams_left.length
  #   tm1 = TeamMatch.create!(match_id: Match.find_by(datetime: datetime[i]).id , team_id: Team.find_by(name: teams_left[i]).id , score: left_score[i], datetime: datetime[i])
  #   tm2 = TeamMatch.create!(match_id: Match.find_by(datetime: datetime[i]).id , team_id: Team.find_by(name: teams_right[i]).id , score: right_score[i], datetime: datetime[i])
  #   i = i + 1
  #   puts "Iteration number #{i}, creating team matches id #{tm1.id} and #{tm2.id}"
  # end
  
  # league_list.each do |l|
  #   League.create!(name: l, game_id: @game_id)
  #   puts "creating league #{l}"
  # end
  
  i = 0
  while i < league_acc.length do
    m = Match.find_by(datetime: datetime[i])
    m.update_attribute("league_id", League.find_by(name: league_acc[i]).id)
    puts "Updating match id #{m} with league #{league_acc[i]}"
    i = i + 1 
  end
  
end