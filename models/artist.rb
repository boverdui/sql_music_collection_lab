require_relative('../db/sql_runner.rb')

class Artist

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql =
    "INSERT INTO artists
    (
      name
    )
    VALUES
    (
      $1
    )
    RETURNING *;"
    result = SqlRunner.run(sql, [@name])
    @id = result[0]['id'].to_i
  end

  def update()
    sql =
    "UPDATE artists SET name = $1 WHERE id = $2;"
    SqlRunner.run(sql, [@name, @id])
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = $1;"
    result = SqlRunner.run(sql, [@id])
    albums = result.map {|album| Album.new(album)}
    return albums
  end

  def Artist.find(id_number)
    sql = "SELECT * FROM artists WHERE id = $1"
    result = SqlRunner.run(sql, [id_number])
    return result.map {|artist| Artist.new(artist)}
  end

  def Artist.delete_all()
    sql = "DELETE FROM artists;"
    SqlRunner.run(sql)
  end

  def Artist.all()
    sql = "SELECT * FROM artists;"
    artists = SqlRunner.run(sql)
    return artists.map {|artists_hash| Artist.new(artists_hash)}
  end

end
