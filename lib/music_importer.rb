require 'pry'
class MusicImporter
  
  attr_accessor :path
  
  def initialize(path)
    @path = path
  end
  
  def files 
    Dir.chdir(@path) {|path| Dir.glob("*.mp3*")}
  end 
  
  def import
    files.each do |filename| 
      Song.create_from_filename(filename)
    end 
  end 
  
end 