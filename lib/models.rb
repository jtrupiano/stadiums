
class Stadium < ActiveRecord::Base
  set_table_name "stadiums"
  def request_path(from, to)
    "http://maps.googleapis.com/maps/api/directions/json?origin=#{URI::encode(from)}&destination=#{URI::encode(to)}&sensor=false"
  end

  def lookup_distance_to(stadium)
    puts "finding distance from #{self.stadium} to #{stadium.stadium}"
    r = open(request_path(self.address, stadium.address))
    json = JSON.parse(r.read)
    OpenStruct.new(
      :minutes => json["routes"].first["legs"].last["duration"]["value"] / 60,
      :miles => json["routes"].first["legs"].last["distance"]["value"] * 0.000621371192
    )
  end
end

class Distance < ActiveRecord::Base
  belongs_to :from_stadium, :class_name => "Stadium", :foreign_key => :from_stadium
  belongs_to :to_stadium, :class_name => "Stadium", :foreign_key => :to_stadium

  def self.between(stadium1, stadium2)
    from = (stadium1.id < stadium2.id)  ? stadium1 : stadium2
    to   = (stadium1.id >= stadium2.id) ? stadium1 : stadium2
    find(:first, :conditions => ["from_stadium = ? AND to_stadium = ?", from.id, to.id])
  end
  
  def self.closest_stadiums_to(stadium)
    find(:all, :conditions => ["from_stadium = ? OR to_stadium = ?", stadium.id, stadium.id], :order => "distance_in_minutes")
  end
end

class Game < ActiveRecord::Base
  belongs_to :home_team, :class_name => "Stadium", :foreign_key => :home_stadium_id
  belongs_to :away_team, :class_name => "Stadium", :foreign_key => :away_stadium_id

  def to_s
    "#{gametime.strftime('%a %m/%d %I:%M%p')} #{away_team.team} @ #{home_team.team}"
  end

  def must_arrive_no_later_than
    self.gametime - 4.hours
  end

  def cannot_leave_earlier_than
    self.gametime + 4.hours
  end

  def can_travel_to?(other_game)
    return false if self.id == other_game.id
    return false if other_game.gametime < self.gametime
    travel_time_required = Distance.between(self.home_team, other_game.home_team).distance_in_minutes 
    total_available_time = other_game.must_arrive_no_later_than - self.cannot_leave_earlier_than
    acceptable_ratio = 0.33333
    return (total_available_time * acceptable_ratio) > travel_time_required
  end
end
