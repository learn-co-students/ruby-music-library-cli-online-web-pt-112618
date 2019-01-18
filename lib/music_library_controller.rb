class MusicLibraryController
  attr_accessor :path

  def initialize(path = "./db/mp3s")
    @path = path
    MusicImporter.new(path).import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = ""
    until input == "exit"
      input = gets.chomp
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

  def play_song
    puts "Which song number would you like to play?"

    input = gets.chomp

    #create an array of songs
    # split that array into nested arrays
    #compare number to array[0] - the index numbered
    songs_arr = []
    ordered = []
    Song.all.collect do |song|
      songs_arr << "#{song.artist.name} - #{song.name} - #{song.genre.name}"
    end

    songs_arr.collect do |song|
      song.split(" - ")
    end.sort {|a,b| a[1] <=> b[1]}.collect do |array|
      array.join(" - ")
    end.each.with_index(1) do |file, index|
        ordered << "#{index}. #{file}"
      end

    ordered.each do |file|
      parsed = file.split(/[.-]/).collect(&:strip)
      if input == parsed[0]
        puts "Playing #{parsed[2]} by #{parsed[1]}"
      end
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp

    songs = []
    Artist.all.collect do |artist|
      if artist.name == input
        artist.songs.each do |song|
          songs << "#{song.name} - #{song.genre.name}"
        end
      end
    end

    songs.sort.each.with_index(1) do |song, index|
      puts "#{index}. #{song}"
    end
  end

  def list_songs_by_genre
  # "prints all songs by a particular genre in a numbered list (alphabetized by song name)"
    puts "Please enter the name of a genre:"
    input = gets.chomp
    #first tried an array, next try a hash?
    songs = Hash.new
    Genre.all.collect do |genre|
      if genre.name == input
        genre.songs.each do |song|
          song.artist.songs.each do |song|
            songs[song.artist.name] = song.name
          end
        end
      end
    end

    songs.sort_by {|k, v| v}.each.with_index(1) do |pair, index|
        puts "#{index}. #{pair.join(" - ")}"
    end
  end


  def list_genres
    Genre.all.collect do |genre|
      genre.name
    end.uniq.sort.each.with_index(1) do |genre, index|
      puts "#{index}. #{genre}"
    end
  end

  def list_artists
    Artist.all.collect do |artist|
      artist.name
    end.sort.each.with_index(1) do |artist, index|
      puts "#{index}. #{artist}"
    end
  end

  def list_songs
    songs_arr = []

    Song.all.collect do |song|
      songs_arr << "#{song.artist.name} - #{song.name} - #{song.genre.name}"
    end

    songs_arr.collect do |song|
      song.split(" - ")
    end.sort {|a,b| a[1] <=> b[1]}.collect do |array|
      array.join(" - ")
    end.each.with_index(1) do |file, index|
        puts "#{index}. #{file}"
      end
  end
end
