# Controller for Movies
class MoviesController < ApplicationController
  skip_before_action :verify_authentication_token
  before_action :tmdb_configuration
  before_action :get_movie, only: %i[show]

  def home
    trailers = []
    x = 0
    movies = JSON.parse(Tmdb::Movie.upcoming.to_json)
    loop do
      trailer = Tmdb::Movie.trailers(movies[x]['id'])['youtube'][0]
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
      movie.poster_path = secure_base_url_with_size(1) + movie.poster_path if movie.poster_path
    end

    render json: movies
  end

  def show
    if @movie['poster_path']
      @movie['poster_path'] = secure_base_url_with_size(2) + @movie['poster_path']
    end
    @movie['casts'] = get_cast
    @movie['user_rating'] = UserMovie.find_by(user_id: User.current.id, imdb_id: @movie['imdb_id'])&.rating if User.current
    @movie['reviews'] = get_reviews

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
      movie.poster_path = secure_base_url_with_size(1) + movie.poster_path if movie.poster_path
    end

    movies
  end

  def get_movie_trailer(movie, trailer)
    {
      id: movie['id'],
      title: movie['title'],
      trailer: {
        name: trailer['name'],
        source: trailer['source']
      }
    }
  end

  def get_cast
    movie_cast = Tmdb::Movie.casts(@movie['id']).select { |cast| cast['character'].present? }
    movie_cast.map do |cast|
      path = get_person_image(cast['profile_path'])
      cast.except('profile_path').merge('profile_path': path)
    end
  end

  def get_person_image(path)
    return unless path

    @configuration.secure_base_url + @configuration.poster_sizes[0] + path
  end

  def get_reviews
    reviews = Review.where(imdb_id: @movie['imdb_id'])
    reviews.map do |review|
      username = User.find(review.user_id).username
      JSON.parse(review.to_json).except(:user_id).merge(written_by_username: username)
    end
  end

  def movie_params
    params.permit(:id, :imdb_id, :title)
  end

  def secure_base_url_with_size(size)
    @configuration.secure_base_url + @configuration.poster_sizes[size]
  end
end
