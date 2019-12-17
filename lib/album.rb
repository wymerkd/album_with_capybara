class Album
  attr_reader :id, :name, :year, :genre, :artist#Our new save method will need reader methods.

  @@albums = {}
  @@total_rows = 0 # We've added a class variable to keep track of total rows and increment the value when an ALbum is added.

  def initialize(name, id, year, genre, artist) # We've added id as a second parameter.
    @name = name
    @id = id || @@total_rows += 1  # We've added code to handle the id.
    @year = year
    @genre = genre
    @artist = artist
  end

  def update(name)
   @name = name
 end

  def save
    @@albums[self.id] = Album.new(self.name, self.id, self.year, self.genre, self.artist)
  end

  def ==(album_to_compare)
    self.name() == album_to_compare.name()
  end

  def self.all
    @@albums.values()
  end

  def self.clear
    @@total_rows = 0
    @@albums = {}
  end

  def self.find(id)
    @@albums[id]
  end

  def delete
    @@albums.delete(self.id)
  end

end
