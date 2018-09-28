require_relative('../db/sql_runner.rb')

class Role

  #####################################################################
  attr_reader(:id, :actor_id, :movie_id)
  attr_accessor(:fee)
  #####################################################################
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @actor_id = options['actor_id']
    @movie_id = options['movie_id']
    @fee = options['fee'].to_i
  end
  #####################################################################
  #####################################################################
  ## CLASS METHODS ##

  def self.all()
    sql = "SELECT * FROM roles"
    roles = SqlRunner.run(sql)
    result = roles.map{|role| Role.new(role)}
    return result
  end
  #####################################################################

  def self.delete_all()
    sql = "DELETE FROM roles"
    SqlRunner.run(sql)
  end
  #####################################################################
  #####################################################################
  ## OBJECT METHODS ##

  def save()
    sql = "INSERT INTO roles(
      actor_id,
      movie_id,
      fee
      )
      VALUES (
        $1, $2, $3
        )
      RETURNING id"
      values = [@actor_id, @movie_id, @fee]
      role = SqlRunner.run(sql, values).first
      @id = role['id'].to_i
  end
  #####################################################################

  def update()
    sql = " UPDATE roles
            SET
            actor_id = $1,
            movie_id = $2,
            fee = $3
            WHERE id = $4;"
    values = [@actor_id, @movie_id, @fee, @id]
    SqlRunner.run(sql,values)
  end
  #####################################################################

  def delete()
    sql = "
    DELETE FROM roles
    WHERE id = $1"
    values = [@id]
   SqlRunner.run(sql, values)
  end

 ######################################################################
 ######################################################################
end ## Class end ##
