class Message < ActiveRecord::Base
  belongs_to :conversation, touch: true
  belongs_to :user
  belongs_to :content, polymorphic: true
  scope :available, -> { where('deleted_at IS NULL') }
  scope :sorted, -> { order('id DESC') }

  rails_admin do
    include_all_fields
    field :content_type
    field :content_id
  end

  def content_summary
    "This is a message id##{self.id}, will be changed later"
  end
end
