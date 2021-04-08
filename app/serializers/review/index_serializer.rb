# Responsible for serializing User's Reviews on login
class Review::IndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :blog, :user_id, :imdb_id
end
