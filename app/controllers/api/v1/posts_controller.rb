class Api::V1::PostsController < Api::V1::BaseApiController
  before_action :require_post, only: [:followers, :follow, :unfollow]

  def index
    @posts = Post.includes({user: [:profile_photo]}, :photos, :video).order("id DESC").to_a

    render json: @posts, each_serializer: Api::V1::Posts::PostSerializer
  end

  def followers
    @followers = @post.followers.includes(:profile_photo)

    render json: @followers, each_serializer: Api::V1::Posts::UserSerializer, root: 'followers'
  end

  def follow
    @post.followed_by(@current_user, follow_params)

    render json: {success: true}, status: :ok
  end

  def unfollow
    @post.unfollowed_by(@current_user)

    render json: {success: true}, status: :ok
  end

  private
  def follow_params
    params.require(:follow).permit(:latitude, :longitude)
  end
end
