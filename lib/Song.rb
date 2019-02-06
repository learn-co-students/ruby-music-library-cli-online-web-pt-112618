class Song
  extend Concerns::Findable
attr_accessor :name, :artist, :genre
@@all=[]
 def initialize(name, artist=nil, genre=nil)
    @name = name
self.artist=artist if artist!=nil
self.genre=genre if genre!=nil
@@all<<self
  end

  def self.create(name, artist=nil, genre=nil)
    a=Song.new(name,artist,genre)
#@@all<<a

return a
end

def self.all
@@all

end

def self.new_from_filename(filename)
  array=filename.split(" - ")
  artist_name=array[0]


  artist=Artist.find_or_create_by_name(artist_name)
  title=array[1]
  genre_name=(array[2].chomp(".mp3"))
  genre=Genre.find_or_create_by_name(genre_name)
  new_song=Song.new(title,artist,genre)
#p
return new_song
end


def self.create_from_filename(filename)

    a=Song.new_from_filename(filename)
#puts "#{a.name}"

return a

  end


   def self.destroy_all
   @@all.clear

    end

    def artist=(artist)
    @artist=artist
    artist.add_song(self)
    end

    def genre=(genre)
      @genre=genre
      genre.songs<<self unless genre.songs.include?(self)
    end


def save
  @@all<<self

end



end
