require_relative('../db/sql_runner.rb')


class Actor

  #####################################################################
  attr_reader(:id)
  attr_accessor(:name)
  #####################################################################
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end
  #####################################################################
  #####################################################################
  ## CLASS METHODS ##

  def self.all()
    sql = "SELECT * FROM actors"
    actors = SqlRunner.run(sql)
    result = actors.map {|actor| Actor.new(actor)}
    return result
  end
  #####################################################################

  def self.delete_all()
    sql = "DELETE FROM actors"
    SqlRunner.run(sql)
  end

  #####################################################################
  #####################################################################
  ## OBJECT METHODS ##

  def save()
    sql = "INSERT INTO actors
    (
      name
      )
      VALUES
      ($1)
      RETURNING id"
      values = [@name]
      actor = SqlRunner.run(sql, values).first
      @id = actor['id'].to_i
  end
  ####################################################################

  def update()
    sql = "
    UPDATE actors
    SET name = $1
    WHERE id = $2;
    "
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end
  #####################################################################

  def delete()
    sql = "
    DELETE FROM actors
    WHERE id = $1"
    values = [@id]
   SqlRunner.run(sql, values)
  end

  ####################################################################
  ####################################################################
    ## JOIN METHODS ##
    ## Called on an object not the class ##

    def movies()
      sql = " SELECT * FROM movies
              INNER JOIN roles
              ON movies.id = roles.movie_id
              WHERE actor_id = $1;"
      movie_hash = SqlRunner.run(sql, [@id])
      movies = movie_hash.map{|movie_hash| Movie.new(movie_hash)}
      return movies
    end


 ######################################################################
 ######################################################################
end ## Class end ##
