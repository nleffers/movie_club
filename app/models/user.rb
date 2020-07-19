class User < ApplicationRecord
  has_many :user_movies
  has_many :movies, through: :user_movies
  has_many :reviews

  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end
end
