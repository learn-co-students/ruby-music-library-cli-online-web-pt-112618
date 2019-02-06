class MusicImporter
@@all=[]


  attr_accessor :path

  def initialize(file_path)
    @path = file_path
    @songs=[]
  end

  def files
 Dir.glob("#{@path}/*.mp3").select { |fn| File.file?(fn)}.map{ |f| File.basename f }

end

  def import
#b=[]
  files.each do |file|
    a=Song.create_from_filename(file)
  #  puts "#{a.name}"
#puts "#{a.name}"
@songs<<a
  end

@songs
    end


def self.all
@@all

end

end
