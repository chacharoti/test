class Api::V1::ActivitiesController < Api::V1::BaseApiController
  def index
    page = (params[:page] || 1).to_i
    activities = @current_user.recent_activities(page)

    render json: activities, each_serializer: Api::V1::Activities::ActivitySerializer, root: 'activities'
  end
end
