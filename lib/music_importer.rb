class MusicImporter
  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def import
    files.each do |file|
      Song.create_from_filename(file)
    end
  end

  def files
     Dir["#{@path}/**/*.mp3"].collect do |file|
       File.basename(file)
     end
  end
end
