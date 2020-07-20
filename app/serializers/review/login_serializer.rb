# Responsible for serializing User's Reviews on login
class Review::LoginSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :blog
end
