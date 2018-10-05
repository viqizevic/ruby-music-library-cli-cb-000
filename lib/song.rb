class Song

  extend Concerns::Memorable::ClassMethods, Concerns::Findable
  include Concerns::Memorable::InstanceMethods

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist=(artist)
    self.genre=(genre)
  end

  def artist=(artist)
    if !artist.nil?
      @artist = artist
      artist.add_song(self)
    end
  end

  def genre=(genre)
    if !genre.nil?
      @genre = genre
      genre.add_song(self)
    end
  end

  def self.all
    @@all
  end

  def self.new_from_filename(filename)
    artist, song, genre = File.basename(filename, '.mp3').split(' - ')
    self.new(song, Artist.find_or_create_by_name(artist),
      Genre.find_or_create_by_name(genre))
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
  end

  def to_s
    "#{artist.name} - #{name} - #{genre.name}"
  end

end
