require 'pry'

class Genre
    extend Concerns::Findable

  attr_accessor :name
  @@all = []

  def initialize(name)
    @name = name
    @@all
    @songs = []
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
    genre = Genre.new(name)
    genre.save
    genre
  end

  def songs
    @songs
  end

  def artists
    #binding.pry
    self.songs.collect {|song| song.artist}.uniq
  end

end
