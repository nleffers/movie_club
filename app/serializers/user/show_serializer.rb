# Responsible for serializing User for show endpoint
class User::ShowSerializer < ActiveModel::Serializer
  attributes :id, :username, :first_name, :last_name, :email
end
