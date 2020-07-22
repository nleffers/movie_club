# Represents a Movie
class Movie < ApplicationRecord
  has_many :user_movies
  has_many :users, through: :user_movies
  has_many :reviews, -> { order(id: :desc) }
end
