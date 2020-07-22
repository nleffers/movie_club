# Responsible for serializing User for show endpoint
class User::ShowSerializer < ActiveModel::Serializer
  attributes :id,
             :username,
             :first_name,
             :last_name,
             :email,
             :email_notifications

  has_many :movies, each_serializer: Movie::IndexSerializer
  has_many :reviews, each_serializer: Review::IndexSerializer
end
