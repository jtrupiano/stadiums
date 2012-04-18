class DbBuilder
  def db
    @_db ||= PGconn.open(:dbname => 'stadiums', :host => 'localhost')
  end

  def create_tables
    create_stadiums_table
    create_distances_table
    create_games_table
  end

  def clear_tables
    sql = <<-SQL
      DROP TABLE IF EXISTS games;
      DROP TABLE IF EXISTS distances;
      DROP TABLE IF EXISTS stadiums;
    SQL
    db.exec(sql)
  end

  def create_stadiums_table
    sql = <<-SQL
      CREATE TABLE stadiums (
        id SERIAL PRIMARY KEY,
        team VARCHAR(55) NOT NULL,
        stadium VARCHAR(100) NOT NULL,
        address VARCHAR(255) NOT NULL
      );
    SQL
    db.exec(sql)
  end

  def create_distances_table
    sql = <<-SQL
      CREATE TABLE distances (
        from_stadium_id integer NOT NULL references stadiums(id),
        to_stadium_id   integer NOT NULL references stadiums(id),
        distance_in_miles   integer NOT NULL,
        distance_in_minutes integer NOT NULL
      );
    SQL
    db.exec(sql)
  end

  def create_games_table
    sql = <<-SQL
      CREATE TABLE games (
        id SERIAL PRIMARY KEY,
        home_stadium_id integer NOT NULL references stadiums(id),
        away_stadium_id integer NOT NULL references stadiums(id),
        gametime timestamp NOT NULL
      )
    SQL
    db.exec(sql)
  end
end
