class Api::V1::ActivitiesController < Api::V1::BaseApiController
  before_action :require_activity, only: [:accept]

  def index
    page = (params[:page] || 1).to_i
    activities = @current_user.recent_activities(page)

    render json: activities, each_serializer: Api::V1::Activities::ActivitySerializer, root: 'activities'
  end

  def accept
    if @activity.to_user_id == @current_user.id
      @activity.accept
      render json: {success: true}, status: :ok
    else
      raise_invalid_params
    end
  end
end
