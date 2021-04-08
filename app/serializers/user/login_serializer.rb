# Responsible for serializing User for show endpoint
class User::LoginSerializer < ActiveModel::Serializer
  attributes :id, :username, :token
end
