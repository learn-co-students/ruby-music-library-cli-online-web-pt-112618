class MusicLibraryController
  attr_reader :path

  def initialize(path = './db/mp3s')
    @path = path
    @importer = MusicImporter.new(self.path)
    @importer.import
  end

  def call
    user_input = ""
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"

    while user_input != "exit"
      user_input = gets.chomp
      case user_input
      when "list artists"
        self.list_artists
      when "list songs"
        self.list_songs
      when "list genres"
        self.list_genres
      when "list artist"
        self.list_songs_by_artist
      when "list genre"
        self.list_songs_by_genre
      when "play song"
        self.play_song
      end
    end
  end

  def sort_by_name(array)
    sorted_array = array.sort_by do |element|
      element.name
    end
    sorted_array
  end

  def list_songs
    sorted_songs = sort_by_name(Song.all)
    sorted_songs.each_with_index do |song, i|
      puts "#{i+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    sorted_artists = sort_by_name(Artist.all)
    sorted_artists.each_with_index do |artist, i|
      puts "#{i+1}. #{artist.name}"
    end
  end

  def list_genres
    sorted_genres = sort_by_name(Genre.all)
    sorted_genres.each_with_index do |genre, i|
      puts "#{i+1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    user_input = gets.chomp
    if Artist.find_by_name(user_input)
      sorted_songs = sort_by_name(Artist.find_by_name(user_input).songs)
      sorted_songs.each_with_index do |song, i|
        puts "#{i+1}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    user_input = gets.chomp
    if Genre.find_by_name(user_input)
      sorted_songs = sort_by_name(Genre.find_by_name(user_input).songs)
      sorted_songs.each_with_index do |song, i|
        puts "#{i+1}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    user_input = gets.chomp
    sorted_songs = sort_by_name(Song.all)
    if user_input.to_i > 0 && user_input.to_i <= sorted_songs.length
      puts "Playing #{sorted_songs[user_input.to_i-1].name} by #{sorted_songs[user_input.to_i-1].artist.name}"
    end
  end

end
