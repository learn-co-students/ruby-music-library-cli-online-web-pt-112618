class Artist
  attr_accessor :name
  attr_reader :songs
  extend Concerns::Findable
  @@all = []

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    new_artist = Artist.new(name)
    new_artist.save
    new_artist
  end

  def initialize(name)
    @name = name
    @songs = []
  end

  def add_song(song)
    song.artist = self if song.artist == nil
    @songs.push(song) unless @songs.include?(song)
  end

  def genres
    @songs.map do |song|
      song.genre
    end.uniq
  end


  def save
    @@all << self
  end
end
