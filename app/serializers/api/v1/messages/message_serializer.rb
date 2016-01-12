class Api::V1::Messages::MessageSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :content_type, :content

  has_one :user, serializer: Api::V1::UserSerializer

  def content
    if object.content
      if object.content_type == 'Text'
        Api::V1::TextSerializer.new(object.content).serializable_hash
      else
        Api::V1::MediaSerializer.new(object.content).serializable_hash
      end
    else
      nil
    end
  end
end
