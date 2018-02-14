require('pry-byebug')
require_relative('models/album.rb')
require_relative('models/artist.rb')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({'name' => 'Bruce Springsteen'})
artist2 = Artist.new({'name' => 'Madonna'})

artist1.save()
artist2.save()

album1 = Album.new({
  'title' => 'Born to Run',
  'genre' => 'rock',
  'artist_id' => artist1.id
})

album2 = Album.new({
  'title' => 'Nebraska',
  'genre' => 'rock',
  'artist_id' => artist1.id
})

album3 = Album.new({
  'title' => 'True Blue',
  'genre' => 'pop',
  'artist_id' => artist2.id
})

album4 = Album.new({
  'title' => 'Ray of Light',
  'genre' => 'pop',
  'artist_id' => artist2.id
})

album1.save()
album2.save()
album3.save()
album4.save()

binding.pry

nil
