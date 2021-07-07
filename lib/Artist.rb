class Artist
extend Concerns::Findable
  attr_accessor :name, :songs



  @@all = []

  def initialize(name)

    @name = name

@songs=[]
@@all<<self
  end

def self.create(name)
new(name).tap{|a| a.save}
#a=Artist.new(name)
#@@all<<a
end

def self.all
  @@all
end
def self.destroy_all
   @@all.clear
 end

 def artist=(artist)
 @artist=artist
 artist.add_song(self)
 end

  def add_song(song)


  song.artist = self unless song.artist==self
 @songs<<song unless @songs.include?(song)
end
def genres
  self.songs2.collect{|s| s.genre}.uniq
end
#end
 def songs2
   Song.all.select do |song1|
     song1.artist == self
   end
  end
  #def add_song_by_name(name)
  #  a=Song.new(name)
  #  add_song(a)
  #end


def save
  # self.class.all << self
  @@all<<self
 end

#  def self.song_count
#    @songs.count
#  end
end
