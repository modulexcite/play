module Play
  class Song
    
    # The persistent ID of the song in the player's database.
    attr_accessor :id

    # The song's title. We use `name` as a stand-in for `title` to stay
    # consistent with Artist and Album names.
    attr_accessor :name

    # The song's String artist value.
    attr_accessor :artist

    # Initializes a new Song.
    #
    # options - One of two possible arguments:
    #           Song.new('2799A5071CD3E516') # creates from a persistent_id
    #           Song.new(args)               # `args` is a Hash of attributes
    #
    # Returns a new Song instance.
    def initialize(options)
      if options.kind_of?(String)
        song = Song.find(options)
        @id     = song.id
        @name   = song.name
        @artist = song.artist
      else
        @id     = options[:id]
        @name   = options[:name]
        @artist = options[:artist]
      end
    end

    # Finds a song in the database.
    #
    # id - The persistent String ID in the player's database.
    #
    # Returns an instance of a Song.
    def self.find(id)
      record = Player.library.tracks[Appscript.its.persistent_ID.eq(id)].get[0]
      new :id     => record.persistent_ID.get,
          :name   => record.name.get,
          :artist => record.artist.get
    end

  end
end