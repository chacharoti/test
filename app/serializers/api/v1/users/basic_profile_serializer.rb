class Api::V1::Users::BasicProfileSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :nickname, :birthday, :gender
end
