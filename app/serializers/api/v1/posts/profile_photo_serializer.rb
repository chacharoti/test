class Api::V1::Posts::ProfilePhotoSerializer < ActiveModel::Serializer
  attributes :id, :file_key
end
