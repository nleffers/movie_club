# Responsible for serializing a Movies
class Movie::IndexSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :rating,
             :rating_count,
             :user_rating

  def user_rating
    return unless User.current

    UserMovie.find_by(
      user_id: User.current.id,
      movie_id: object.id
    )&.rating
  end
end
