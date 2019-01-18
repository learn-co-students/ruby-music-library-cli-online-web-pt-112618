class Song
  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=(artist) if artist
    self.genre=(genre) if genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    #tap returns the object passed in to the block - the new song instance itself
    Song.new(name).tap{ |song| song.save }
  end

  def artist=(artist)
      @artist = artist
      artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self if !genre.songs.include?(self)
  end

  def self.find_by_name(name)
    all.find {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end

  def self.new_from_filename(file_name)
    file = file_name.chomp(".mp3").split(" - ")
    song = file[1]
    artist = Artist.find_or_create_by_name(file[0])
    genre = Genre.find_or_create_by_name(file[2])
    Song.new(song, artist, genre)

    #Song.new(file[1], Artist.find_or_create_by_name(file[0]), Genre.find_or_create_by_name(file[2]))
  end

  def self.create_from_filename(file_name)
    all << new_from_filename(file_name)
  end
end
