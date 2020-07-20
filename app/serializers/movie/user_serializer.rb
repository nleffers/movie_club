# Responsible for serializing a User's Movies
class Movie::UserSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :rating,
             :rating_count
end
