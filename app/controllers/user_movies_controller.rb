# Controller for UserMovies
class UserMoviesController < ApplicationController
  skip_before_action :verify_authentication_token, only: %i[index show]
  before_action :get_movie, only: %i[show rate]

  def index
    movie_ids = UserMovie.where(user_id: user_params[:user_id] || User.current.id).pluck(:imdb_id)

    render json: movie_ids.map { |id| Tmdb::Find.imdb_id(id) }, serializer: Movie::IndexSerializer
  end

  def show
    render json: @movie, serializer: Movie::ShowSerializer
  end

  def rate
    movie = UserMovie.find_by(user_id: User.current.id, imdb_id: params[:imdb_id]) ||
            UserMovie.create(user_id: User.current.id, imdb_id: params[:imdb_id])
    movie.update(rating: params[:rating])

    head :ok
  end

  private

  def get_movie
    @movie = Tmdb::Find.imdb_id(params[:id])
  end

  def user_params
    params.permit(:id, :user)
  end

  def movie_params
    params.permit(:id, :imdb_id, :title)
  end

  def rating_params
    params.permit(:imdb_id, :rating)
  end
end
