class Genre
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
  def save
    @@all<<self

  end

  def artists
    self.songs2.collect{|s| s.artist}.uniq
  end
#  end
   def songs2
     Song.all.select do |song1|
       song1.genre == self
     end
    end


    def self.all
      @@all
    end
       def self.destroy_all
       @@all.clear

        end

end
