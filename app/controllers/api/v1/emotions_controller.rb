class Api::V1::EmotionsController < Api::V1::BaseApiController
  before_action :require_post, only: [:index, :create, :remove]

  def index
    @emotions = @post.emotions.includes([:emotion, {user: [:profile_photo]}])

    render json: @emotions, each_serializer: Api::V1::Posts::EmotionSerializer
  end

  def create
    @emotion = @post.add_emotion(@current_user, emotion_params)

    render json: {success: true}, status: :ok
  end

  def remove
    @post.remove_emotion(@current_user)

    render json: {success: true}, status: :ok
  end

  private
  def emotion_params
    params.require(:emotion).permit(:id)
  end
end
