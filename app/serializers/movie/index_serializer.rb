# Responsible for serializing a Movies
class Movie::IndexSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :vote_average,
             :vote_count,
             :poster_path,
             :user_rating

  def poster_path
    configuration = Tmdb::Configuration.new
    configuration.secure_base_url + configuration.poster_sizes[1] + object['poster_path']
  end

  def user_rating
    return unless User.current

    UserMovie.find_by(user_id: User.current.id, imdb_id: object['imdb_id'])&.rating
  end
end
