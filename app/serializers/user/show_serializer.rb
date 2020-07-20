# Responsible for serializing User for show endpoint
class User::ShowSerializer < ActiveModel::Serializer
  attributes :id,
             :username,
             :first_name,
             :last_name,
             :email,
             :email_notifications,
             :token

  has_many :movies, through: :user_movies, each_serializer: Movie::UserSerializer
  has_many :reviews, each_serializer: Review::UserSerializer
end
