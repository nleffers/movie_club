class MoviesController < ApplicationController
  before_action :get_movie, only: [:create, :show, :update, :rate]

  def new
  end

  def create
  end

  def index
  end

  def show
    render json: movie
  end

  def update
  end

  def rate
  end

  private

  def get_movie
    movie = Movie.find(params[:id])
  end
end
