class Post < ActiveRecord::Base
  belongs_to :user
  has_many :photos, -> { distinct }, as: :owner
  has_one :video, as: :owner
end
