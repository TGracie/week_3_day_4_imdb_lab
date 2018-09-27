require_relative('models/actor.rb')
require_relative('models/role.rb')
require_relative('models/movie.rb')
require('pry')

# Actor.delete_all()
# Movie.delete_all()
# Role.delete_all()

#######################################################################
######################################################################
## ACTORS ##
  actor1 = Actor.new({
    'name' => 'Brad Pitt'
    })

    actor1.save()

  actor2 = Actor.new({
    'name' => 'Christoph Waltz'
    })

    actor2.save()

#######################################################################
#######################################################################
## MOVIES ##

  movie1 = Movie.new({
    'title' => 'Inglorious Basterds',
    'genre' => 'Comedy'
    })

  movie2 = Movie.new({
    'title' => 'Catch Me If You Can',
    'genre' => 'Horror'
    })

    movie1.save()
    movie2.save()

#######################################################################
#######################################################################
## ROLES ##

  role1 = Role.new({
    'actor_id' => actor1.id,
    'movie_id' => movie1.id,
    'fee' => 200000
    })

  role2 = Role.new({
    'actor_id' => actor2.id,
    'movie_id' => movie2.id,
    'fee' => 150000
    })

  role1.save()
  role2.save()

binding.pry
nil
