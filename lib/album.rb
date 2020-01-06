class Album
  attr_accessor :name

  # Class variables have been removed.

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id) # Note that this line has been changed.
  end

  def ==(other)
  self.class.eql?(other.class) & self.name.eql?(other.name)
  end

  def self.all
  returned_albums = DB.exec("SELECT * FROM albums;")
  albums = []
  returned_albums.each() do |album|
    name = album.fetch("name")
    id = album.fetch("id").to_i
    albums.push(Album.new({:name => name, :id => id}))
  end
  albums
end

def save
  result = DB.exec("INSERT INTO albums (name) VALUES ('#{@name}') RETURNING id;")
  @id = result.first().fetch("id").to_i
end
def self.clear
  DB.exec("DELETE FROM albums *;")
end
def self.find(id)
  album = DB.exec("SELECT * FROM albums WHERE id = #{id};").first
  name = album.fetch("name")
  id = album.fetch("id").to_i
  Album.new({:name => name, :id => id})
end
def update(name)
  @name = name
  DB.exec("UPDATE albums SET name = '#{@name}' WHERE id = #{@id};")
end

def delete
  DB.exec("DELETE FROM albums WHERE id = #{@id};")
end
#

  # def update(name, year, genre, artist)
  #   @name = name
  #   @year = year
  #   @genre = genre
  #   @artist = artist
  # end
  #
  # def save
  #   @@albums[self.id] = Album.new(self.name, self.id, self.year, self.genre, self.artist)
  # end
  #
  # def ==(album_to_compare)
  #   self.name() == album_to_compare.name()
  # end
  #
  # def self.all
  #   @@albums.values()
  # end
  #
  # def self.clear
  #   @@total_rows = 0
  #   @@albums = {}
  # end
  #
  # def self.find(id)
  #   @@albums[id]
  # end
  #
  # def delete
  #   @@albums.delete(self.id)
  # end
  #
  # def self.sort
  #   @@albums.values.sort {|a, b| a.name.downcase <=> b.name.downcase}
  # end
  #
  # def self.search(x)
  #   @@albums.values.select { |e| /#{x}/i.match? e.name}
  # end
  #
  # def songs                         #find songs by album
  #   Song.find_by_album(self.id)
  # end

end

 # reg ex = {paramter passed in}/(not case sensitive)
