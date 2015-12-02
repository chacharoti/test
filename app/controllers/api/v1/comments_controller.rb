class Api::V1::CommentsController < Api::V1::BaseApiController
  before_action :require_post, only: [:index]

  def index
    @comments = @post.comments.includes([user: [:profile_photo]])

    render json: @comments, each_serializer: Api::V1::Posts::CommentSerializer
  end
end
