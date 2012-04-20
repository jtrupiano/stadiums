require './environment'

# route_1_games = Game.find(
#   [843,845,857,859,874,885,890,900,909,919,929,932,940,951,958,966,973,986,989,1000,1005,1015,1027,1034,1035,1043,1051,1052,1067,1070,1082,1084]
# )

# scheduler = Scheduler.new(route_1_games)
# puts scheduler.to_csv

def already_visited?(memo, game)
  memo.map(&:home_stadium_id).include?(game.home_stadium_id)
end

games_we_cannot_make = 
  [111] + # NE at STL in London
  Array(134..145) + # Sunday games for Tony's wedding weekend
  [220] # SEA at BUF in Toronto

@all_games = Game.where("id NOT IN (?)", games_we_cannot_make).includes([:home_team, :away_team])
def games_we_care_about(memo)
  ret = @all_games.select {|g| 
    !already_visited?(memo, g) && 
      memo.last.should_consider_traveling_to?(g) &&
        memo.last.can_travel_to?(g)
  }
end

CHAIN_SIZE = 32
@cnt = 0
def find_next_game(memo)
  games = games_we_care_about(memo)
  games.each do |g|
    if memo.last.can_travel_to?(g)
      memo.push(g)
      if memo.size >= CHAIN_SIZE
        ScheduleOutputter.new(memo).save_to_csv(@cnt += 1)
      end
      find_next_game(memo)
      memo.pop
    end
  end
end

chain = Array(Game.first(:include => [:home_team, :away_team]))
find_next_game(chain)
chain.pop
