
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


def week1_games
  week1_games = Game.find(:all, :conditions => ["gametime < ?", Time.local(2011, 9, 13)])
  week1_games.each do |g1|
    week1_games.each do |g2|
      if g1.can_travel_to?(g2)
        puts "#{g1} to #{g2}"
      end
    end
  end
end

def schedule
  Game.where(:home_stadium_id => [2,3,4,5,6,7,8,11,12,14,15,17,18,19,21,22,24,25,30,31,32]).each do |g|
    puts g.to_s
  end
end


class Scheduler
  attr_reader :games
  def initialize(games)
    @games = games
  end

  def to_csv
    last_game = nil
    games.each do |game|
      puts game
      if last_game
        distance = Distance.between(game.home_team, last_game.home_team)
        puts "  #{(game.must_arrive_no_later_than - last_game.cannot_leave_earlier_than) / 3600.0} hours to travel #{distance.distance_in_miles} miles (#{distance.distance_in_minutes / 60.0} hours)"
      end
      last_game = game
    end
  end
end

games = Game.find(
  [843,845,857,859,874,885,890,900,909,919,929,932,940,951,958,966,973,986,989,1000,1005,1015,1027,1034,1035,1043,1051,1052,1067,1070,1082,1084]
)

scheduler = Scheduler.new(games)
puts scheduler.to_csv
