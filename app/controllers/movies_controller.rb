# Controller for Movies
class MoviesController < ApplicationController
  skip_before_action :verify_authentication_token, only: %i[index search show]
  before_action :get_movie, only: %i[create show]
  before_action :tmdb_configuration, only: %i[index popular_movies now_playing upcoming show]

  def index
    movies = Tmdb::Movie.top_rated
    movies.each do |movie|
      movie.poster_path = @configuration.secure_base_url + @configuration.poster_sizes[1] + movie.poster_path
    end

    render json: movies
  end

  def search
    render json: Tmdb::Movie.find(movie_params[:title]), each_serializer: Movie::IndexSerializer
  end

  def popular_movies
    movies = Tmdb::Movie.popular
    movies.each do |movie|
      movie.poster_path = @configuration.secure_base_url + @configuration.poster_sizes[1] + movie.poster_path
    end

    render json: movies
  end

  def now_playing
    movies = Tmdb::Movie.now_playing
    movies.each do |movie|
      movie.poster_path = @configuration.secure_base_url + @configuration.poster_sizes[1] + movie.poster_path
    end

    render json: movies
  end

  def upcoming
    movies = Tmdb::Movie.upcoming
    movies.each do |movie|
      movie.poster_path = @configuration.secure_base_url + @configuration.poster_sizes[1] + movie.poster_path
    end

    render json: movies
  end

  def show
    @movie['poster_path'] = @configuration.secure_base_url + @configuration.poster_sizes[1] + @movie['poster_path']
    @movie['user_rating'] = UserMovie.find_by(user_id: User.current.id, imdb_id: @movie['imdb_id'])&.rating
    @movie['reviews'] = Review.where(imdb_id: @movie['imdb_id'])
    render json: @movie
  end

  private

  def tmdb_configuration
    @configuration = Tmdb::Configuration.new
  end

  def get_movie
    @movie = Tmdb::Movie.detail(params[:id])
  end

  def movie_params
    params.permit(:id, :imdb_id, :title)
  end
end
