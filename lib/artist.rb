require 'pry'

class Artist
    extend Concerns::Findable
    
  attr_accessor :name
  @@all = []

  def initialize(name)
    @name = name
    @@all
    @songs = [] #has many songs
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
    artist = Artist.new(name)
    artist.save
    artist
  end

  def songs #has many songs
    @songs
  end

  def add_song(song) #song belongs to artist
    if song.artist != self #if current song does not have an artist property
    song.artist = self #assigns the current artist to the song's 'artist' property
    end
    @songs << song unless @songs.include?(song)
    #songs
  end

  def genres #has many through
#binding.pry
    self.songs.collect {|song| song.genre}.uniq
#Genre object and its list of songs objects
  #returns a collection of genres for all of the artist's songs
  end

end
