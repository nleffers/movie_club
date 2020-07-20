# Responsible for serializing a User's Moviess
class Movie::LoginSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :rating,
             :rating_count,
             :user_rating

  def user_rating
    UserMovie.find_by(
      user_id: User.current.id,
      movie_id: object.id
    )&.rating
  end
end
