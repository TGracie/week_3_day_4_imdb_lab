require_relative('../db/sql_runner.rb')


class Movie

  #####################################################################
  attr_reader(:id)
  attr_accessor(:title, :genre)
  #####################################################################
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
  end
  #####################################################################
  #####################################################################
  ## CLASS METHODS ##

  def self.all()
    sql = "SELECT * FROM movies"
    movies = SqlRunner.run(sql) ## array ish thing!
    result = movies.map{|movie| Movie.new(movie)} ## turn that into an actual array
    return result
  end
  #####################################################################

  def self.delete_all()
    sql = "DELETE FROM movies"
    SqlRunner.run(sql)
  end

  #####################################################################
  #####################################################################
  ## OBJECT METHODS ##

  def save()
    sql = "INSERT INTO movies
    (
      title,
      genre
      )
    VALUES(
      $1, $2
      )
    RETURNING id"
    values = [@title, @genre]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end
  #####################################################################

  def update()

    sql = "UPDATE movies
    SET title = $1,
        genre = $2
    WHERE id = $3;"

    values = [@title, @genre, @id]

    SqlRunner.run(sql, values)
  end
  #####################################################################

  def delete()
    sql = "
    DELETE FROM movies
    WHERE id = $1"
    values = [@id]
   SqlRunner.run(sql, values)
  end

  ####################################################################
  ####################################################################
  ## JOIN METHODS ##
  ## Called on an object not the class ##

  def actors()
    sql = " SELECT * FROM actors
            INNER JOIN roles
            ON actors.id = roles.actor_id
            WHERE movie_id = $1;"
    actor_hash = SqlRunner.run(sql, [@id])
    actors = actor_hash.map{|actor_hash| Actor.new(actor_hash)}
    return actors
  end

 ######################################################################
 ######################################################################
end ## Class end ##
