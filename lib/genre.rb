class Genre

  extend Concerns::Memorable::ClassMethods, Concerns::Findable
  include Concerns::Memorable::InstanceMethods

  attr_accessor :name
  attr_reader :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def add_song(song)
    if !song.nil?
      if !@songs.include?(song)
        @songs << song
      end
      song.genre = self if song.genre.nil?
    end
  end

  def artists
    songs.map { |s| s.artist }.uniq
  end

end
