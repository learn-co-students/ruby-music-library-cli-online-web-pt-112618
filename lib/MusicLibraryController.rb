class MusicLibraryController

def initialize(path = "./db/mp3s")

  importer=MusicImporter.new(path)

  @songs=importer.import
#@songs=[]
end
def list_songs

  #ar=@songs
@songs.sort! {|a,b| a.name.downcase <=> b.name.downcase}
i=0
@songs.each do |a|
 puts "#{i+1}. #{a.artist.name} - #{a.name} - #{a.genre.name}"
 i+=1
 end
 end



def call
  input=""
  while input!="exit"
  puts "Welcome to your music library!"
puts "To list all of your songs, enter 'list songs'."
puts "To list all of the artists in your library, enter 'list artists'."

    input=gets.strip
case input
when "list songs"
  songs
when "list artists"
  artists
when "list genres"
  genres
when "list artist"
  list artist
when "list genre"
  list genre
when "play song"
  play song
end
end
end
end
