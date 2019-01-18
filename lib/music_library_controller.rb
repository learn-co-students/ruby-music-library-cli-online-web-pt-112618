require 'pry'
class MusicLibraryController  
  
  def initialize(path ="./db/mp3s") 
   importer = MusicImporter.new(path)
   importer.import
  end 
  
  def call 
    user_input = ""
    while user_input != "exit"
    
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
    
      user_input = gets.chomp
      case user_input
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
      when "exit"
    
      end 
      
    end
    
    def list_songs
      lists = []
      Song.all.each do |song|
        lists += [song.name, song.artist.name, song.genre.name]
      end
      
      sorted_lists = lists.each_slice(3).map {|list| list}.sort
      sorted_lists.each.with_index(1) do |list, index|
        puts "#{index}. #{list[1]} - #{list[0]} - #{list[2]}"
      end
      
    end

    def list_artists
      sorted = Artist.all.map {|artist| artist.name}.sort
      sorted.each.with_index(1) {|artist, index| puts "#{index}. #{artist}"}  
    end 
      
    def list_genres
      sorted = Genre.all.map {|genre| genre.name}.sort
      sorted.each.with_index(1) {|genre, index| puts "#{index}. #{genre}"}  
    end 
    
    def list_songs_by_artist
      puts "Please enter the name of an artist:"
      user_input = gets.chomp
      
      lists = []
      Song.all.each do |song|
        if song.artist.name == user_input  
          lists += [song.name, song.genre.name]
        end
      end
      
      sorted_lists = lists.each_slice(2).map {|list| list}.sort
      sorted_lists.each.with_index(1) do |list, index|
        puts "#{index}. #{list[0]} - #{list[1]}"
      end
    end 
    
    def list_songs_by_genre 
      puts "Please enter the name of a genre:"
      user_input = gets.chomp
     
      lists = []
      Song.all.each do |song|
        if song.genre.name == user_input  
          lists += [song.name, song.artist.name]
        end
      end
      
      sorted_lists = lists.each_slice(2).map {|list| list}.sort
      sorted_lists.each.with_index(1) do |list, index|
        puts "#{index}. #{list[1]} - #{list[0]}"
      end
    end 
    
    def play_song
      puts "Which song number would you like to play?"
      user_input = gets.chomp
      index = user_input.to_i - 1
      
      lists = []
      Song.all.each do |song|
        lists += [song.name, song.artist.name, song.genre.name]
      end
      
      sorted_lists = lists.each_slice(3).map {|list| list}.sort
      puts "Playing #{sorted_lists[index][0]} by #{sorted_lists[index][1]}" if index > 1 && index < sorted_lists.length
    end  
    
  end  #the end of call method    
  
end 