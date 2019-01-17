class Genre
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
    new_genre = Genre.new(name)
    new_genre.save
    new_genre
  end

  def initialize(name)
    @name = name
    @songs = []
  end

  def add_song(song)
    song.genre = self if song.genre == nil
    @songs.push(song) unless @songs.include?(song)
  end

  def artists
    @songs.map do |song|
      song.artist
    end.uniq
  end

  def save
    @@all << self
  end

end
