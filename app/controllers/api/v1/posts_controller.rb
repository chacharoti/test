class Api::V1::PostsController < Api::V1::BaseApiController
  before_action :require_post, only: [:followers]

  def index
    @posts = Post.includes({user: [:profile_photo]}, :photos, :video).order("id DESC").to_a

    render json: @posts, each_serializer: Api::V1::Posts::PostSerializer
  end

  def followers
    @followers = @post.followers.includes(:profile_photo)

    render json: @followers, each_serializer: Api::V1::Posts::UserSerializer, root: 'followers'
  end
end
