class UserLocation < ActiveRecord::Base
  belongs_to :user

  validates :latitude, presence: true
  validates :longitude, presence: true
end
