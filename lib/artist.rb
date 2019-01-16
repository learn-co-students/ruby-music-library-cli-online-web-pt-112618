class Artist
  attr_accessor :name
  attr_reader :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    self.new(name).save
    self
  end

  def add_song(song)
    if !@songs.include?(song)
      @songs << song
      song.artist = self if song.artist != self
    end
  end
end
