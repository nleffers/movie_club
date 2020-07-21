# Responsible for serializing a Review
class Review::ShowSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :blog
end
