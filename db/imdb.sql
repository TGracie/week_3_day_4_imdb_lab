DROP TABLE IF EXISTS roles; --this is the child, must kill it first (because that's not fucked up!)
DROP TABLE IF EXISTS actors;
DROP TABLE IF EXISTS movies;

CREATE TABLE actors(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE movies(
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  genre VARCHAR(255)
);

CREATE TABLE roles(
  id SERIAL4 PRIMARY KEY,
  actor_id INT4 REFERENCES actors(id) ON DELETE CASCADE,
  movie_id INT4 REFERENCES movies(id) ON DELETE CASCADE,
  fee INT4
);
