# Responsible for serializing a Movie
class Movie::ShowSerializer < ActiveModel::Serializer
  attributes :id,
             :imdb_id,
             :title,
             :rating,
             :rating_count,
             :user_rating

  has_many :reviews, serializer: Review::ShowSerializer

  def user_rating
    return unless User.current

    UserMovie.find_by(user_id: User.current.id, imdb_id: object.imdb_id)&.rating
  end
end
