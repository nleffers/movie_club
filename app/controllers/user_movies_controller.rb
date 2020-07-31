# Controller for UserMovies
class UserMoviesController < ApplicationController
  before_action :get_movie

  def rate
    movie = UserMovie.find_by(user_id: User.current.id, imdb_id: rating_params[:imdb_id]) ||
            UserMovie.create(user_id: User.current.id, imdb_id: rating_params[:imdb_id])
    movie.update(rating: rating_params[:rating])

    head :ok
  end

  private

  def get_movie
    @movie = Tmdb::Find.imdb_id(params[:id])
  end

  def rating_params
    params.permit(:imdb_id, :rating)
  end
end
