class Text < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  validates :raw, presence: true
end
