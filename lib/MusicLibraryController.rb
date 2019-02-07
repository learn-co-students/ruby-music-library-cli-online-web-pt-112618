class MusicLibraryController

def initialize(path = "./db/mp3s")

  importer=MusicImporter.new(path)

  @songs=importer.import
#@songs=[]
end
def list_artists

@artists=Artist.all
  #ar=@songs
#  @songs.uniq! {|a| a.artist.name}
#@songs.sort! {|a,b| a.artist.name.downcase <=> b.artist.name.downcase}
#i=0
#@songs.each do |a|
# puts "#{i+1}. #{a.artist.name}"
 #i+=1
 #end
 @artists.uniq! {|a| a.name}
 @artists.sort! {|a,b| a.name.downcase <=> b.name.downcase}
 i=0
 @artists.each do |a|
  puts "#{i+1}. #{a.name}"
  i+=1
  end

 end


def list_songs_by_artist
  input=""
  #while input!="exit"
  puts "Please enter the name of an artist:"
  input=gets.strip

  if input!=""

   i=0
   @songs1=Song.all
result=  @songs1.select { |song1| song1.artist.name == input}
if result!=nil
  result.sort! {|a,b| a.name.downcase <=> b.name.downcase}
  result.each do |song1|
      puts "#{i+1}. #{song1.name} - #{song1.genre.name}"
      i+=1
#  end
   end
end
end
end

def list_songs_by_genre
  input=""
  #while input!="exit"
  puts "Please enter the name of a genre:"
  input=gets.strip

  if input!=""

   i=0
   @songs1=Song.all
result=  @songs1.select { |song1| song1.genre.name == input}
if result!=nil
  result.sort! {|a,b| a.name.downcase <=> b.name.downcase}
  result.each do |song1|
      puts "#{i+1}. #{song1.artist.name} - #{song1.name}"
      i+=1
#  end
   end
end
end
end
 def list_genres

 @genres=Genre.all
   #ar=@songs
 #  @songs.uniq! {|a| a.artist.name}
 #@songs.sort! {|a,b| a.artist.name.downcase <=> b.artist.name.downcase}
 #i=0
 #@songs.each do |a|
 # puts "#{i+1}. #{a.artist.name}"
  #i+=1
  #end
  @genres.uniq! {|a| a.name}
  @genres.sort! {|a,b| a.name.downcase <=> b.name.downcase}
  i=0
  @genres.each do |a|
   puts "#{i+1}. #{a.name}"
   i+=1
   end
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

def play_song
#  list_songs
 @songs.sort! {|a,b| a.name.downcase <=> b.name.downcase}
  input=""
  #while input!="exit"
  puts "Which song number would you like to play?"
  input=gets.strip
num=input.to_i
  if (num>=1) && (num <@songs.length)

a=@songs[num-1]
  puts  "Playing #{a.name} by #{a.artist.name}"
end
end

def call
  input=""
  while input!="exit"
  puts "Welcome to your music library!"
puts "To list all of your songs, enter 'list songs'."
puts "To list all of the artists in your library, enter 'list artists'."
puts "To list all of the genres in your library, enter 'list genres'."
puts "To list all of the songs by a particular artist, enter 'list artist'."
puts "To list all of the songs of a particular genre, enter 'list genre'."
puts "To play a song, enter 'play song'."
puts "To quit, type 'exit'."
puts "What would you like to do?"

    input=gets.strip
case input
when "list songs"
  list_songs
when "list artists"
  list_artists
when "list genres"
  list_genres
when "list artist"
  list_songs_by_artist
when "list genre"
  list_songs_by_genre
when "play song"
  play_song
end
end
end
end
