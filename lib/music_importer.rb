class MusicImporter
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def files
    #binding.pry
    Dir.glob("#{@path}/*.mp3").map{|file| file.gsub("#{@path}/","")}
  end

  def import
#binding.pry
    files.each {|file|Song.create_from_filename(file)}
  end

end
