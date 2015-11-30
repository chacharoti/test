class Api::V1::PostsController < Api::V1::BaseApiController
  def index
    @posts = Post.includes([:photos, :video]).order("id DESC").to_a

    render json: @posts, each_serializer: Api::V1::Posts::PostSerializer
  end
end
