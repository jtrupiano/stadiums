class Stadium < ActiveRecord::Base
  set_table_name "stadiums"
  def request_path(from, to)
    "http://maps.googleapis.com/maps/api/directions/json?origin=#{URI::encode(from)}&destination=#{URI::encode(to)}&sensor=false"
  end

  def lookup_distance_to(stadium)
    puts "finding distance from #{self.stadium} to #{stadium.stadium}"
    r = open(request_path(self.address, stadium.address))
    json = JSON.parse(r.read)
    begin
      return OpenStruct.new(
        :minutes => json["routes"].first["legs"].last["duration"]["value"] / 60,
        :miles => json["routes"].first["legs"].last["distance"]["value"] * 0.000621371192
      )
    rescue NoMethodError
      puts "Google throttled us...waiting 30 seconds and retrying."
      sleep(30)
      retry
    end
  end
end

class Distance < ActiveRecord::Base
  belongs_to :from_stadium, :class_name => "Stadium", :foreign_key => :from_stadium_id
  belongs_to :to_stadium, :class_name => "Stadium", :foreign_key => :to_stadium_id

  def self.between(stadium1, stadium2)
    @distances ||= {}
    from = (stadium1.id < stadium2.id)  ? stadium1 : stadium2
    to   = (stadium1.id >= stadium2.id) ? stadium1 : stadium2
    @distances["#{from.id}_#{to.id}"] ||= find(:first, :conditions => {:from_stadium_id => from.id, :to_stadium_id => to.id})
  end
  
  def self.closest_stadiums_to(stadium)
    find(:all, :conditions => ["from_stadium = ? OR to_stadium = ?", stadium.id, stadium.id], :order => "distance_in_minutes")
  end

  def distance_in_hours
    @distance_in_hours ||= self.distance_in_minutes / 60.0
  end
end

class Game < ActiveRecord::Base
  belongs_to :home_team, :class_name => "Stadium", :foreign_key => :home_stadium_id
  belongs_to :away_team, :class_name => "Stadium", :foreign_key => :away_stadium_id
  has_many :traveling_games, :foreign_key => :from_game_id

  def to_s
    @s ||= "#{gametime.strftime('%a %m/%d %I:%M%p')} #{away_team.team} @ #{home_team.team}"
  end

  def must_arrive_no_later_than
    @must_arrive_no_later_than ||= self.gametime - 4.hours
  end

  def must_arrive_no_later_than_in_seconds_since_epoch
    @must_arrive_no_later_than_in_seconds_since_epoch ||= self.must_arrive_no_later_than.to_i
  end

  def cannot_leave_earlier_than
    @cannot_leave_earlier_than ||= self.gametime + 4.hours
  end

  def cannot_leave_earlier_than_in_seconds_since_epoch
    @cannot_leave_earlier_than_in_seconds_since_epoch ||= self.cannot_leave_earlier_than.to_i
  end

  def next_game_threshold
    @next_game_threshold ||= self.gametime + 9.days
  end

  def next_game_threshold_in_seconds_since_epoch
    @next_game_threshold_in_seconds_since_epoch ||= self.next_game_threshold.to_i
  end

  def can_travel_to?(other_game)
    return false if same_game?(other_game)
    acceptable_downtime = 10 # hours
    return (available_time_in_hours_between(other_game) - travel_time_required_in_hours_between(other_game)) > acceptable_downtime
  end

  # don't skip more than a week
  def should_consider_traveling_to?(other_game)
    # other_game.week - self.week <= 1
    other_game.must_arrive_no_later_than_in_seconds_since_epoch < self.next_game_threshold_in_seconds_since_epoch
  end

  private
    def same_game?(other_game)
      self.id == other_game.id
    end

    def travel_time_required_in_hours_between(other_game)
      Distance.between(self.home_team, other_game.home_team).distance_in_hours
    end

    def available_time_in_hours_between(other_game)
      (other_game.must_arrive_no_later_than - self.cannot_leave_earlier_than) / 3600.0
    end
end


class TravelingGame < ActiveRecord::Base
  belongs_to :from_game, :class_name => 'Game', :foreign_key => :from_game_id
  belongs_to :to_game,   :class_name => 'Game', :foreign_key => :to_game_id
  belongs_to :from_stadium, :class_name => 'Stadium', :foreign_key => :from_stadium_id
  belongs_to :to_stadium,   :class_name => 'Stadium', :foreign_key => :to_stadium_id
end
