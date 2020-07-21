# Responsible for serializing User for show endpoint
class User::ShowSerializer < ActiveModel::Serializer
  attributes :id,
             :username,
             :first_name,
             :last_name,
             :email,
             :email_notifications,
             :token

  has_many :movies, serializer: Movie::IndexSerializer
  has_many :reviews, serializer: Review::IndexSerializer
end
