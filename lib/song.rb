require 'pry'
class Song  
  attr_accessor :name, :artist, :genre
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist ##add artist as option unless artist=nil
    self.genre = genre if genre
  end 
  
  def save
    @@all << self
  end 
  
  def self.all 
    @@all 
  end 
  
  def self.destroy_all
    self.all.clear
  end 
  
  def self.create(name, artist = nil, genre = nil)
    Song.new(name, artist, genre).tap do |song| 
      song.save
    end 
  end 
  
  def artist=(artist)
    @artist = artist 
    artist.add_song(self)
  end 
  
   def genre=(genre)
    @genre = genre  
    genre.add_song(self)
  end 
  
  def self.find_by_name(name)
    self.all.detect do |song|
      song if song.name == name 
    end 
  end 
  
  def self.find_or_create_by_name(name)
    self.find_by_name(name) ||  self.create(name) 
  end 
  
  def self.new_from_filename(filename)
    file = filename.split(" - ")
    artist_name, song_name, genre_name = file[0],file[1],file[2].gsub(".mp3", "")
    
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    self.new(song_name, artist, genre)
  end
  
  def self.create_from_filename(filename)
    self.new_from_filename(filename).save
  end 
  
end 