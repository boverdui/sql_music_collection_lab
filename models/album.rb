require_relative('../db/sql_runner.rb')

class Album

  attr_accessor :title, :genre
  attr_reader :id, :artist_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql =
    "INSERT INTO albums
    (
      title,
      genre,
      artist_id
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING *;"
    result = SqlRunner.run(sql, [@title, @genre, @artist_id])
    @id = result[0]['id'].to_i
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1;"
    result = SqlRunner.run(sql, [@artist_id])
    return Artist.new(result[0])
  end

  def Album.delete_all()
    sql = "DELETE FROM albums;"
    SqlRunner.run(sql)
  end

  def Album.all()
    sql = "SELECT * FROM albums;"
    albums = SqlRunner.run(sql)
    return albums.map {|albums_hash| Album.new(albums_hash)}
  end

end
