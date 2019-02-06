class MusicImporter
@@all=[]


  attr_accessor :path

  def initialize(file_path)
    @path = file_path
  end

  def files
 Dir.glob("#{@path}/*.mp3").select { |fn| File.file?(fn)}.map{ |f| File.basename f }

end

  def import

  files.each do |file|
    Song.create_from_filename(file)
  #  puts "#{b.name}"

  end


    end


def self.all
@@all

end

end
