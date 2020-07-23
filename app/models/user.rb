# Represents a User
class User < ApplicationRecord
  has_secure_password

  has_many :user_movies
  has_many :movies, through: :user_movies
  has_many :reviews

  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end

  def favorite_movies
    user_movies.pluck(:imdb_id).map { |id| Tmdb::Movie.detail(id) }
  end
end
