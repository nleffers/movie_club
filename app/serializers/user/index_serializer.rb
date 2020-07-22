# Responsible for serializing a Movie
class User::IndexSerializer < ActiveModel::Serializer
  attributes :id,
             :username,
             :email,
             :first_name,
             :last_name
end

