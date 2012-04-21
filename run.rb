require './environment'

minimum_downtime = ARGV.size > 0 ? ARGV[0].to_i : 10
acceptable_drive_v_downtime_ratio = ARGV.size > 1 ? ARGV[1].to_f : 2.0

games_we_cannot_make = 
  [111] + # NE at STL in London
  Array(134..145) + # Sunday games for Tony's wedding weekend
  [220] # SEA at BUF in Toronto

all_games = Game.where("id NOT IN (?)", games_we_cannot_make).includes([:home_team, :away_team])

Runner.new(minimum_downtime, acceptable_drive_v_downtime_ratio).solve!(all_games)
