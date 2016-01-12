class Message < ActiveRecord::Base
  belongs_to :conversation, touch: true
  belongs_to :user
  belongs_to :content, polymorphic: true
  scope :available, -> { where('deleted_at IS NULL') }
  scope :sorted, -> { order('created_at DESC') }

  def content_summary
    "This is a message id##{self.id}, will be changed later"
  end
end
