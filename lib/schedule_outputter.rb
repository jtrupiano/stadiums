class ScheduleOutputter
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
