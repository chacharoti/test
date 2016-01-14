class Message < ActiveRecord::Base
  belongs_to :conversation, touch: true
  belongs_to :user
  has_one :text, as: :owner
  has_one :photo, as: :owner
  has_one :video, as: :owner

  attr_accessor :content_type
  CONTENT_TYPES = %w(Text Photo Video)

  scope :available, -> { where('deleted_at IS NULL') }
  scope :sorted, -> { order('id DESC') }

  def content_summary
    "This is a message id##{self.id}, will be changed later"
  end

  def content_attributes=(attributes)
    if self.content_type == 'Text'
      self.create_text(attributes)
    elsif self.content_type == 'Photo'
      self.create_photo(attributes)
    elsif self.content_type == 'Video'
      self.create_video(attributes)
    else
      raise "Unknown content_type: #{self.content_type}"
    end
  end
end
