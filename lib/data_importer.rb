require 'open-uri'

class DataImporter
  
  def db
    @_db ||= PGconn.open(:dbname => 'stadiums', :host => 'localhost')
  end

  def import_data
    import_stadiums
    import_distances
  end

  def clear_data
    sql = <<-SQL
      DELETE ALL FROM games;
      DELETE ALL FROM distances;
      DELETE ALL FROM stadiums;
    SQL
  end

  def import_stadiums
    lines = File.readlines('stadiums.txt')
    lines_grouped_by_stadium = lines.inject([]) {|memo, line|
      if line =~ /^Team/
        memo << [line]
      else
        memo.last << line
      end
      memo
    }

    lines_grouped_by_stadium.each do |lines_for_stadium|
      team = lines_for_stadium[0].match(/^Team:\s(.+)/)[1]
      stadium = lines_for_stadium[5].match(/^Stadium:\s(.+)/)[1]
      address = lines_for_stadium[7].match(/^Address:\s(.+)/)[1]
      puts "#{team} #{stadium} #{address}"
      db.exec("INSERT INTO stadiums(team, stadium, address) VALUES('#{team}', '#{stadium}', '#{address}');")
    end
    puts "#{lines_grouped_by_stadium.size} stadiums"
  end

  def import_distances(clear_first=true)
    Distance.delete_all if clear_first

    stadiums = Stadium.all
    distances = Distance.all
    stadiums.each do |from|
      stadiums.each do |to|
        next if to.id <= from.id || distances.detect {|distance| distance.from_stadium_id == from.id && distance.to_stadium_id == to.id}
        distances_from_google = from.lookup_distance_to(to)
        distances << Distance.create!(
          :from_stadium => from, :to_stadium => to, 
          :distance_in_miles => distances_from_google.miles, 
          :distance_in_minutes => distances_from_google.minutes
        )
      end
    end
  end

  def import_schedule
    doc = Nokogiri::HTML(open('schedule2012.html'))

    doc.css('table').each do |tbl|
      tbl.css('tr.colhead').each do |date_tr|
        date_text = date_tr.css('td:first').text.split(", ")[1]
        date_text << get_year(date_text)

        game_tr   = date_tr.next_element
        while (!game_tr.nil? && game_tr.attributes["class"].value.include?("team"))
          time_text = game_tr.css("td")[1].text

          gametime = DateTime.parse("#{date_text} #{time_text}")
          away_city = read_city(game_tr.css("td:first a")[0].text)
          home_city = read_city(game_tr.css("td:first a")[1].text)

          away = Stadium.find(:first, :conditions => ["team LIKE ?", "#{away_city}%"])
          home = Stadium.find(:first, :conditions => ["team LIKE ?", "#{home_city}%"])

          g = Game.create!(:home_team => home, :away_team => away, :gametime => gametime)
          puts g.to_s

          game_tr = game_tr.next_element
        end
      end
    end
  end

  private
    def get_year(date_str)
      date_str.include?("JAN") ? " 2013" : " 2012"
    end

    def read_city(city)
      return "New York Giants" if city == "NY Giants"
      return "New York Jets" if city == "NY Jets"
      city
    end
end
