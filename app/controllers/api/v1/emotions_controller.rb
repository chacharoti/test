class Api::V1::EmotionsController < Api::V1::BaseApiController
  before_action :require_post, only: [:index]

  def index
    @emotions = @post.emotions.includes([:emotion, {user: [:profile_photo]}])

    render json: @emotions, each_serializer: Api::V1::Posts::EmotionSerializer
  end
end
