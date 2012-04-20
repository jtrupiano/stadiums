class ScheduleOutputter
  attr_reader :games
  def initialize(games)
    @games = games
  end

  def total_mileage
    games_as_struct.slice(1, 32).inject(0) { |memo, game|
      memo + game.distance_to_travel
    }
  end

  def down_times
    games_as_struct.slice(1, 32).map {|game| game.down_time}
  end

  def smallest_down_time
    down_times.min
  end

  def save_to_csv(route_num)
    puts "Route #{route_num}: #{total_mileage} miles, #{smallest_down_time} hours smallest down time"
    File.open("routes/#{route_num}.csv", 'w') {|f| f.write(self.to_csv) }
  end

  def games_as_struct
    @games_as_struct ||= begin
      last_game = nil
      games.map do |game|
        struct = OpenStruct.new(
          :id => game.id,
          :gamedate => game.gametime.strftime("%m/%d/%y"),
          :gametime => game.gametime.strftime("%I:%M %p"),
          :away_team => game.away_team.team,
          :home_team => game.home_team.team
        )
        if last_game
          distance = Distance.between(game.home_team, last_game.home_team)
          hours_available = (game.must_arrive_no_later_than_in_seconds_since_epoch - last_game.cannot_leave_earlier_than_in_seconds_since_epoch) / 3600.0
          down_time = hours_available - distance.distance_in_hours

          struct.distance_to_travel = distance.distance_in_miles
          struct.hours_available    = hours_available
          struct.driving_time       = distance.distance_in_hours
          struct.down_time          = distance.down_time
        else
          struct.distance_to_travel = "N/A"
          struct.hours_available    = "N/A"
          struct.driving_time       = "N/A"
          struct.down_time          = "N/A"
        end
        last_game = game
        struct
      end
    end
  end

  def to_csv
    CSV.generate do |csv|
      csv << ["ID", "Game Date", "Game Time", "Away Team", "Home Team", "Distance to Travel", "Hours Available", "Driving Time", "Down Time"]

      games_as_struct.each do |game|
        row = [
          game.id,
          game.gamedate,
          game.gametime,
          game.away_team,
          game.home_team,
          game.distance_to_travel,
          game.hours_available,
          game.driving_time,
          game.down_time
        ]
        csv << row
      end
    end
  end
end
