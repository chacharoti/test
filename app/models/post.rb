class Post < ActiveRecord::Base
  has_many :photos, -> { distinct }, as: :owner
  has_one :video, as: :owner
end
