class Message < ActiveRecord::Base
  belongs_to :conversation, touch: true
  belongs_to :user
  belongs_to :content, polymorphic: true
  accepts_nested_attributes_for :content
  after_save :update_content_type

  CONTENT_TYPES = %w(Text Photo Video)

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

  def content_attributes=(attributes)
    raise "Unknown content_type: #{self.content_type}" unless CONTENT_TYPES.include?(self.content_type)
    content = self.content_type.constantize.find_or_initialize_by(id: self.content_id)
    content.attributes = attributes
    self.content = content
  end

  def update_content_type
    if self.content != nil && self.content_type != self.content.type
      self.update_attribute(:content_type, self.content.type)
    end
  end
end
