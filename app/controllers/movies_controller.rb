# Controller for Movies
class MoviesController < ApplicationController
  skip_before_action :verify_authentication_token, only: %i[index show]
  before_action :get_movie, only: %i[create show update destroy rate]

  def new; end

  def create
    movie = Movie.create(movie_params)

    render json: movie, serializer: Movie::ShowSerializer
  end

  def index
    render json: Movie.all, each_serializer: Movie::IndexSerializer
  end

  def show
    render json: @movie, serializer: Movie::ShowSerializer
  end

  def update
    @movie.update(movie_params)

    render json: @movie, serializer: Movie::ShowSerializer
  end

  def destroy
    @movie.destroy

    head :ok
  end

  def rate
    user_movie = UserMovie.find_by(user_id: User.current.id, movie_id: params[:id])
    previous_user_rating = user_movie.rating || 0

    user_movie.update(rating: params[:rating])
    @movie.assign_attributes(rating: @movie.rating + params[:rating] - previous_user_rating)
    @movie.assign_attributes(rating_count: @movie.rating_count + 1) if previous_user_rating.zero?
    @movie.save

    head :ok
  end

  private

  def get_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.permit(:id,
                  :title)
  end

  def rating_params
    params.permit(:id,
                  :rating)
  end
end
