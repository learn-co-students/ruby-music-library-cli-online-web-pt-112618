class Song

  attr_accessor :name
  attr_reader   :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.find_by_name(name)
    all.detect do |s|
      s.name == name
    end
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end

  def self.new_from_filename(name)

    file = name.split(" - ")
    artist_name, song_name, genre_name = file[0], file[1], file[2].gsub(".mp3", "") #gsub essentially gets rid of the .mp3 file extension - second argument will replace the first one
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)

    new(song_name, artist, genre) #create a new song object and pass in the song name, an artist object, and a genre object
  end

  def self.create_from_filename(name)
    new_from_filename(name).save
  end

end
