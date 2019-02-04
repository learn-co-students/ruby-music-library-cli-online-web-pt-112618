require 'pry'

class Song
  attr_accessor :name
  attr_reader :artist, :genre #song belongs to artist so create a custom setter
  @@all = []

  def initialize(name, artist = nil, genre = nil)#optiotnal 2nd argument(song belongs to artist)
    @name = name
    self.artist = artist if artist #Song initialize (song belongs to artist)
    self.genre = genre if genre
    @@all
  end

  def artist=(artist) #song belongs to artist setter
    @artist = artist
    artist.add_song(self) #artists have many songs
      #invokes Artist add_song to add itself to the artist's collection of songs (artist has many songs)
  end

  def genre=(genre)
    #binding.pry
    @genre = genre
    genre.songs << self unless genre.songs.include?(self) #genre has many songs
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def self.find_by_name(name)
    @@all.find {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end

  def self.new_from_filename(file_name)
    song = file_name.split(" - ")[1]
    artist = file_name.split(" - ")[0]
    genre = file_name.split(" - ")[2].gsub(".mp3","")

    song = self.new(song)
    song.artist = Artist.find_or_create_by_name(artist)
    song.genre = Genre.find_or_create_by_name(genre)
    song
    #binding.pry
  end

  def self.create_from_filename(file_name)
#binding.pry
    Song.new_from_filename(file_name).save
  end

end
