class Genre  
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
    @@all.clear
  end 
  
  def self.create(name)
    Genre.new(name).tap {|g| g.save} 
    # g = Genre.new(name)
    # g.save 
    # g
  end 
  
  def add_song(song)
    song.genre = self unless song.genre == self
    @songs << song unless @songs.include?(song)
  end 
  
  def artists  
    self.songs.map{|song| song.artist}.uniq
  end
  
end 