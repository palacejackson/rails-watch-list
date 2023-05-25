# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "json"
require "open-uri"

puts 'Cleaning database...'
Movie.destroy_all

puts 'Creating movies...'

url = 'https://tmdb.lewagon.com/movie/top_rated'
movie_serialized = URI.open(url).read
movies = JSON.parse(movie_serialized)


movies['results'].each do |movie|
  @movie = Movie.new(
    title: movie['title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/original#{movie['poster_path']}",
    rating: movie['vote_average']
  )
  @movie.save!
end

puts 'Finished!'
