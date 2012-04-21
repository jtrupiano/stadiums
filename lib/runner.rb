class Runner
  CHAIN_SIZE = 32
  attr_reader :all_games, :minimum_downtime, :acceptable_drive_v_downtime_ratio
  def initialize(minimum_downtime, acceptable_drive_v_downtime_ratio)
    Game.minimum_downtime                  = minimum_downtime
    Game.acceptable_drive_v_downtime_ratio = acceptable_drive_v_downtime_ratio

  end

  def games_we_care_about(memo)
    ret = @all_games.select {|g| 
      !already_visited?(memo, g) && 
        memo.last.should_consider_traveling_to?(g) &&
          memo.last.can_travel_to?(g)
    }
  end

  def already_visited?(memo, game)
    memo.map(&:home_stadium_id).include?(game.home_stadium_id)
  end

  def find_next_game(memo)
    games = games_we_care_about(memo)
    games.each do |g|
      if memo.last.can_travel_to?(g)
        memo.push(g)
        if memo.size >= CHAIN_SIZE
          ScheduleOutputter.new(memo).save_to_csv(@cnt += 1)
        end
        if memo.size == 2
          puts memo.last.to_s
        end
        find_next_game(memo)
        memo.pop
      end
    end
  end

  def solve!(games)
    @all_games = games
    @cnt       = 0
    chain      = Array(Game.first(:include => [:home_team, :away_team]))
    find_next_game(chain)
  end
end
