class Genre
  attr_accessor :name
  attr_reader :songs
  @@all = []

  extend Concerns::Findable

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
    @@all.last
  end

  def artists
    songs.map {|song| song.artist}.uniq
  end
end
