class Video < Medium
  store :meta_data, accessors: [:thumbnail_size, :duration]
  validates :thumbnail_size, presence: true
  validates :duration, presence: true

  def thumbnail_url
    "#{self.identifier_url}_thumbnail.jpg"
  end

  def video_url
    "#{self.identifier_url}.mp4"
  end
end
