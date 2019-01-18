require 'pry'
class Artist 
  
  extend Concerns::Findable
  
  attr_accessor :name, :songs
  @@all = []
  
  def initialize(name)
    @name = name
    @songs = []
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
  
  def add_song(song)
    song.artist = self unless song.artist == self
    @songs << song unless @songs.include?(song)
  end 
  
  def self.create(name)
    new(name).tap {|a| a.save}
    
    #before refactor these two are the same
    #Artist.new(name).tap {|a| a.save}    
    
    # a = Artist.new(name)
    # a.save 
    # a
  end 
  
  def genres
    self.songs.map {|song| song.genre}.uniq
  end
  
  
end