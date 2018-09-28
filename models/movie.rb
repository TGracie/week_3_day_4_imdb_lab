require_relative('../db/sql_runner.rb')


class Movie

  #####################################################################
  attr_reader(:id)
  attr_accessor(:title, :genre, :budget)
  #####################################################################
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @budget = options['budget'].to_i
  end
  ####################################################################
  ####################################################################
  ## CLASS METHODS ##

  def self.all()
    sql = "SELECT * FROM movies"
    movies = SqlRunner.run(sql) ## array ish thing!
    result = movies.map{|movie| Movie.new(movie)} ## turn that into an actual array
    return result
  end
  ####################################################################

  def self.delete_all()
    sql = "DELETE FROM movies"
    SqlRunner.run(sql)
  end
  ####################################################################
  ####################################################################
  ## OBJECT METHODS ##

  def save()
    sql = "INSERT INTO movies
    (
      title,
      genre,
      budget
      )
    VALUES(
      $1, $2, $3
      )
    RETURNING id"
    values = [@title, @genre, @budget]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end
  #####################################################################

  def update()

    sql = "UPDATE movies
    SET title = $1,
        genre = $2,
        budget = $3
    WHERE id = $4;"

    values = [@title, @genre, @budget, @id]

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
  ####################################################################

  def roles()
    sql = "SELECT * FROM roles
    WHERE movie_id = $1"
    values = [@id]
    role_data = SqlRunner.run(sql, values)
    return role_data.map{|role| Role.new(role)}
  end
  ####################################################################

  def remaining_budget()
    # roles = self.roles() #is called from above
    role_fees = roles.map{|role| role.fee}
    combined_fees = role_fees.sum
    return @budget - combined_fees
  end

 #####################################################################
 #####################################################################
end ## Class end ##
