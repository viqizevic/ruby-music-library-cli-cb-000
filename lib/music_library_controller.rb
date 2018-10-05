class MusicLibraryController

  def initialize(path="./db/mp3s")
    MusicImporter.new(path).import
  end

  def call
    puts "Welcome to your music library!"
    help
    ask
  end

  def help
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
  end

  def ask
    puts "What would you like to do?"
    input = gets.strip
    if "exit" != input and "q" != input
      if 'list songs' == input or 'ls' == input
        list_songs
      elsif 'list artists' == input or 'la' == input
        list_artists
      elsif 'list genres' == input or 'lg' == input
        list_genres
      elsif 'list artist' == input or 'sa' == input
        list_songs_by_artist
      elsif 'list genre' == input or 'sg' == input
        list_songs_by_genre
      elsif 'play song' == input or 'p' == input
        play_song
      elsif 'h' == input
        help
      end
      ask
    end
  end

  def sort_by_name(list=[])
    list.sort_by{|item| item.name}
  end

  def list_songs(songs=Song.all)
    sort_by_name(songs).each_with_index do |song, index|
      puts "#{index+1}. #{!block_given? ? song : yield(song)}"
    end
  end

  def list_artists
    sort_by_name(Artist.all).each_with_index do |artist, index|
      puts "#{index+1}. #{artist.name}"
    end
  end

  def list_genres
    sort_by_name(Genre.all).each_with_index do |genre, index|
      puts "#{index+1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist = Artist.find_by_name(gets.strip)
    if !artist.nil?
      list_songs(artist.songs) {|s| "#{s.name} - #{s.genre.name}"}
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre = Genre.find_by_name(gets.strip)
    if !genre.nil?
      list_songs(genre.songs) {|s| "#{s.artist.name} - #{s.name}"}
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    index = get_valid_number_index
    if index
      list = sort_by_name(Song.all)
      if index < list.size
        song = list[index]
        puts "Playing #{song.name} by #{song.artist.name}"
      end
    end
  end

  def get_valid_number_index
    input = gets.strip
    if input.match(/^\d+$/)
      index = input.to_i
      return index - 1 if index >= 1
    end
    nil
  end

end
