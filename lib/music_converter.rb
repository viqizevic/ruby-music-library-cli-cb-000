class MusicImporter

  attr_reader :path, :files

  def initialize(filepath)
    @path = filepath
    @files = Dir.glob("#{@path}/**/*.mp3").map { |f| File.basename(f) }
  end

  def import
    @files.collect { |f| Song.create_from_filename(f) }
  end

end
