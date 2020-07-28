# Controller for Movies
class MoviesController < ApplicationController
  skip_before_action :verify_authentication_token, only: %i[home index search show]
  before_action :get_movie, only: %i[show]
  before_action :tmdb_configuration, only: %i[home index search show]

  def home
    trailers = []
    x = 0
    movies = Tmdb::Movie.upcoming
    loop do
      trailer = Tmdb::Movie.trailers(movies[x].id)['youtube'][0]
      next unless trailer['name'] && trailer['source']

      trailers << get_movie_trailer(movies[x], trailer)
      break if trailers.count == 5

      x += 1
    end

    render json: trailers
  end

  def index
    movie_results = {
      top_rated: get_movies_with_poster(Tmdb::Movie.top_rated),
      popular: get_movies_with_poster(Tmdb::Movie.popular),
      now_playing: get_movies_with_poster(Tmdb::Movie.now_playing),
      upcoming: get_movies_with_poster(Tmdb::Movie.upcoming)
    }

    render json: movie_results
  end

  def search
    movies = Tmdb::Movie.find(movie_params[:title])
    movies.each do |movie|
      movie.poster_path = @configuration.secure_base_url + @configuration.poster_sizes[0] + movie.poster_path if movie.poster_path
    end

    render json: movies
  end

  def show
    if @movie['poster_path']
      @movie['poster_path'] = @configuration.secure_base_url + @configuration.poster_sizes[1] + @movie['poster_path']
    end
    @movie['user_rating'] = UserMovie.find_by(user_id: User.current.id, imdb_id: @movie['imdb_id'])&.rating if User.current
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

  def get_movies_with_poster(movies)
    movies.each do |movie|
      movie.poster_path = @configuration.secure_base_url + @configuration.poster_sizes[1] + movie.poster_path if movie.poster_path
    end

    movies
  end

  def get_movie_trailer(movie, trailer)
    {
      id: movie.id,
      title: movie.title,
      trailer: {
        name: trailer['name'],
        source: trailer['source']
      }
    }
  end

  def movie_params
    params.permit(:id, :imdb_id, :title)
  end
end
