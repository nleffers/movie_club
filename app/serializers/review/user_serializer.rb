# Responsible for serializing a User's Reviews
class Review::UserSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :blog
end
