# Represents a UserMovie, the through that connects users and movies
class UserMovie < ApplicationRecord
  belongs_to :movie
  belongs_to :user
end
