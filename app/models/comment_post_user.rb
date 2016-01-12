class CommentPostUser < ActiveRecord::Base
  belongs_to :post, counter_cache: :comments_count
  belongs_to :location, class_name: 'UserLocation'
  belongs_to :user

  def longitude
    self.location.try(:longitude)
  end

  def latitude
    self.location.try(:latitude)
  end
end
