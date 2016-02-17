class Api::V1::EmotionsController < Api::V1::BaseApiController
  before_action :require_post, only: [:index, :create, :remove]

  def index
    emotions = @post.all_emotions

    render json: emotions, each_serializer: Api::V1::Posts::EmotionSerializer
  end

  def create
    emotion = @post.add_emotion(@current_user, emotion_params)

    if emotion == nil
      render json: {success: false, error: 'Already added emotion'}, status: :unprocessable_entity
    elsif emotion.valid? == false
      render json: {success: false, errors: emotion.errors.full_messages}, status: :unprocessable_entity
    else
      render json: {success: true}, status: :ok
    end
  end

  def remove
    @post.remove_emotion(@current_user)

    render json: {success: true}, status: :ok
  end

  private
  def emotion_params
    params.require(:emotion).require(:emotion_type_id)
    params.require(:emotion).permit(:emotion_type_id)
  end
end
