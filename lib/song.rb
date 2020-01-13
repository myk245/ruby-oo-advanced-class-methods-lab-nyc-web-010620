class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    @@all << self 
    # self.class.all << self
  end

  # initializes a song and saves it to
  # the `@@all` class variable either literally or through the class method
  # Song.all`. This method should return the song instance that was initialized and
  # saved.
  def self.create
    song = self.new 
    # #save is an instance method! it can only be called on an instance!
    song.save 
    return song 
  end 

  # .new_by_name instantiates a song with a name property
  def self.new_by_name(name)
    song = self.new  
    song.name = name 
    song 
  end 
  
  # .create_by_name instantiates and saves a song with a name property
  def self.create_by_name(name)
    # to instantiate and save the song, we have to call the .create method instead of .new 
    song = self.create  
    song.name = name 
    song 
  end 

  # accepts the string name of a song
  # and returns the matching instance of the song with that name
  def self.find_by_name(name)
    @@all.find{|song| song.name == name}
  end 

  # In order to prevent duplicate songs being created that actually represent the
  # same song (based on the song name), we're going to build a
  # `Song.find_or_create_by_name` class method. This method will accept a string
  # name for a song and either return a matching song instance with that name or
  # create a new song with the name and return the song instance.
  
  # if the song exists already, return the matching instance of the song with that name
  # if the song does not exist yet, create the song using the .create_by_name method 
  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create_by_name(name)
    # if the left side is true, the self.find_by_name method will be called
    # if the left side is false, the method on the right side will be called 
  end 

  def self.alphabetical
    @@all.sort_by{|song| song.name}
  end 

  # initializes a song and artist_name based on the filename format
  def self.new_from_filename(filename)
    # filename format: <Artist Name - Song Name.mp3>
    # First, we need to separate Artist Name from Song Name by the '-' delimiter
    # Then we need to remove the ".mp3" part of the string from the Song Name 
    song_array = filename.split(" - ")
    # the split method returns an array, so we can use the index to select the element we want 
    artist_name = song_array[0]
    # the below two lines based on @hala1224's code on Repl.it
    # <https://repl.it/@hala1224/Advanced-Class-Methods-Song>
    song_name = song_array[1].split(".")
    # now, to select just the song name without the extension, we need t
    # to use the array's index to select just the song name
    name = song_name[0]

    song = self.new
    song.name = name  
    song.artist_name = artist_name
    song 
  end 

  # initializes and saves a song and artist_name based on the filename format
  def self.create_from_filename(filename)
    song_array = filename.split(" - ")
    artist_name = song_array[0]
    song_name = song_array[1].split(".")
    name = song_name[0]

    # we want to save the song, so we use .create 
    song = self.create
    song.name = name 
    song.artist_name = artist_name
    song
  end 

  # clears all the song instances from the @@all array
  def self.destroy_all
    # @@all.clear 
    # uses the Array#clear method to empty the @@all array through the class reader Song.all
    self.all.clear 
  end 

end
