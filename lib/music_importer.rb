class MusicImporter

  attr_reader :path

  def initialize(path)
    @path = path
  end

  def files
    @files ||= Dir.glob("#{path}/*.mp3").collect{ |f| f.gsub("#{path}/", "") }
  end

  def import
    files.each do |file|
      Song.create_from_filename(file) #iterate over each file and pass the filename into Song.create_from_filename
    end
  end

end
