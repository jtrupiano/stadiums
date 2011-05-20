require 'csv'
require 'rubygems'
require 'bundler/setup'

Bundler.require

ActiveRecord::Base.establish_connection(:adapter => 'postgresql', :database => 'stadiums')

$: << '.'
require 'lib/models'
require 'lib/data_importer'

# importer = DataImporter.new
# importer.import_stadiums
# importer.import_distances
# importer.import_schedule


class Scheduler
  attr_reader :games
  def initialize(games)
    @games = games
  end

  def to_csv
    CSV.generate do |csv|
      csv << ["ID", "Game Date", "Game Time", "Away Team", "Home Team", "Distance to Travel", "Hours Available", "Driving Time", "Down Time"]

      last_game = nil
      games.each do |game|
        row = [game.id, game.gametime.strftime("%m/%d/%y"), 
          game.gametime.strftime("%I:%M %p"),
          game.away_team.team, game.home_team.team
        ]
        if last_game
          distance = Distance.between(game.home_team, last_game.home_team)
          hours_available = (game.must_arrive_no_later_than_in_seconds_since_epoch - last_game.cannot_leave_earlier_than_in_seconds_since_epoch) / 3600.0
          down_time = hours_available - distance.distance_in_hours

          row << distance.distance_in_miles
          row << hours_available
          row << distance.distance_in_hours
          row << hours_available - distance.distance_in_hours
        else
          row << "N/A"
          row << "N/A" 
          row << "N/A" 
          row << "N/A"
        end
        csv << row
        last_game = game
      end
    end
  end
end

# route_1_games = Game.find(
#   [843,845,857,859,874,885,890,900,909,919,929,932,940,951,958,966,973,986,989,1000,1005,1015,1027,1034,1035,1043,1051,1052,1067,1070,1082,1084]
# )

# scheduler = Scheduler.new(route_1_games)
# puts scheduler.to_csv

def games_for_week(num)
  back  = Time.local(2011, 9, 13 + ((num - 1) * 7))
  front = Time.local(2011, 9, 13 + ((num - 2) * 7))
  Game.find(:all, :conditions => ["gametime < ? AND gametime > ?", back, front])
end

def week1
  week1 = games_for_week(1)
  week1.each do |g1|
    week1.each do |g2|
      if g1.can_travel_to?(g2)
        week1.each do |g3|
          if g2.can_travel_to?(g3)
            puts "#{g1.home_team.team} to #{g2.home_team.team} to #{g3.home_team.team}"
          end
        end
      end
    end
  end
end

# @all_games = Game.find(:all, :include => [:home_team, :away_team]) #, :conditions => ["gametime < ?", Time.local(2011,10,18)])
@all_games = Game.find(:all, :include => [:home_team, :away_team], :conditions => ["gametime < ?", Time.local(2011,11,13)])
def games_we_care_about(memo)
  ret = @all_games.select {|g| 
    g.must_arrive_no_later_than_in_seconds_since_epoch > memo.last.cannot_leave_earlier_than_in_seconds_since_epoch && 
      g.must_arrive_no_later_than_in_seconds_since_epoch < memo.last.next_game_threshold_in_seconds_since_epoch &&
      !memo.map(&:home_stadium_id).include?(g.home_stadium_id)
  }
end

# def games_we_care_about(memo)
#   TravelingGame.find(:all, :include => :to_game, :conditions => ["to_stadium_id NOT IN (?) AND from_stadium_id = ?", memo.map(&:home_stadium_id), memo.last.home_stadium_id]).map(&:to_game)
# end

CHAIN_SIZE = 32
@cnt = 0
def find_next_game(memo)
  games = games_we_care_about(memo)
  games.each do |g|
    puts g if memo.size == 19
    puts "    #{g}" if memo.size == 20
    if memo.last.can_travel_to?(g)
      memo.push(g)
      if memo.size >= CHAIN_SIZE
        puts "DING DING DING WE HAVE A WINNER"
        File.open("discovered_route#{@cnt += 1}.csv", 'w') {|f| f.write(Scheduler.new(memo).to_csv) }
      end
      find_next_game(memo)
      memo.pop
    end
  end
end

chain = Game.find([986,989,1000,1005,1015,1027,1034,1035,1043,1051,1052,1067,1070,1082,1084], :include => [:home_team, :away_team])
Game.find([843,844,858], :include => [:home_team, :away_team]).each do |g| chain << g; end
find_next_game(chain)
chain.pop
