# Controller for Movies
class MoviesController < ApplicationController
  before_action :get_movie, only: %i[create show update destroy rate]

  def new; end

  def create
    Movie.create(movie_params)
  end

  def index
    Movie.all
  end

  def show
    @movie
  end

  def update
    @movie.update(movie_params)

    @movie
  end

  def destroy
    @movie.destroy

    @movie
  end

  def rate
    @movie.rating += params[:rating]
    @movie.rating_count += params[:rating_count]
    @movie.save

    @movie
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
                  :rating,
                  :rating_count)
  end
end
