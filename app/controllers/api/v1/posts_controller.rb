class Api::V1::PostsController < Api::V1::BaseApiController
  before_action :require_post, only: [:followers, :follow, :unfollow]

  def index
    render_posts(Post.latest_items.to_a)
  end

  def load_new
    highest_score = params[:highest_score].try(:to_i)
    if highest_score.present? && highest_score > 0
      render_posts(Post.new_items(highest_score).to_a)
    else
      render json: {error: 'Invalid score'}, status: :unprocessable_entity
    end
  end

  def load_more
    lowest_score = params[:lowest_score].try(:to_i)
    if lowest_score.present? && lowest_score > 0
      render_posts(Post.more_items(lowest_score).to_a)
    else
      render json: {error: 'Invalid score'}, status: :unprocessable_entity
    end
  end

  def create
    post = @current_user.add_new_post(create_post_params)
    if post.valid?
      render json: {post_id: post.id}, status: :ok
    else
      render json: {errors: post.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def followers
    @followers = @post.followers.includes(:profile_photo)

    render json: @followers, each_serializer: Api::V1::UserSerializer, root: 'followers'
  end

  def follow
    follow = @post.followed_by(@current_user)

    if follow == nil
      render json: {success: false, error: 'Already followed'}, status: :unprocessable_entity
    elsif follow.valid? == false
      render json: {success: false, errors: follow.errors.full_messages}, status: :unprocessable_entity
    else
      render json: {success: true}, status: :ok
    end
  end

  def unfollow
    @post.unfollowed_by(@current_user)

    render json: {success: true}, status: :ok
  end

  private
  def create_post_params
    params.require(:post).require(:message)
    params.require(:post).permit(:message, photos_attributes: [:file_key, meta_data: [:thumbnail_size, :normal_size]], video_attributes: [:file_key, meta_data: [:thumbnail_size, :duration]])
  end

  def render_posts posts
    render json: posts, each_serializer: Api::V1::Posts::PostSerializer, current_user: @current_user
  end
end
