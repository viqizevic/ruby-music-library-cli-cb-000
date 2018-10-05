class Artist

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
      song.artist = self if song.artist.nil?
    end
  end

  def genres
    songs.map { |s| s.genre }.uniq
  end

end
