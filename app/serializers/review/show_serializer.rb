# Responsible for serializing a Review
class Review::ShowSerializer < ActiveModel::Serializer
  attributes :id,
             :written_by_username,
             :title,
             :blog

  def written_by_username
    User.find_by(id: object.user_id)&.username
  end
end
