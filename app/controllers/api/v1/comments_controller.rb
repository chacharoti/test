class Api::V1::CommentsController < Api::V1::BaseApiController
  before_action :require_post, only: [:index, :create]

  def index
    @comments = @post.comments.includes([user: [:profile_photo]])

    render json: @comments, each_serializer: Api::V1::Posts::CommentSerializer
  end

  def create
    if comment = @post.add_comment(@current_user, comment_params)
      render json: {comment_id: comment.id}, status: :ok
    else
      render json: {errors: @post.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:latitude, :longitude, :message)
  end
end
