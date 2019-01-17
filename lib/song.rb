class Song
  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    new_song = Song.new(name)
    new_song.save
    new_song
  end

  def initialize(name, artist=nil, genre = nil)
    @name = name
    self.artist = artist unless artist == nil
    self.genre = genre unless genre == nil
  end

  def artist=(artist)
    @artist=artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre=genre
    genre.add_song(self)
  end

  def self.find_by_name(name)
    self.all.find do |song|
      song.name == name
    end
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end

  def self.new_from_filename(file)
    name = file.split(" - ")[1]
    artist = file.split(" - ")[0]
    genre = file.split(" - ")[2].split(".")[0]
    new_song = Song.new(name)
    new_song.artist = Artist.find_or_create_by_name(artist)
    new_song.artist.add_song(new_song)
    new_song.genre = Genre.find_or_create_by_name(genre)
    new_song.genre.add_song(new_song)
    new_song
  end

  def self.create_from_filename(file)
    song = self.new_from_filename(file)
    song.save
    song
  end



  def save
    @@all << self
  end

end
