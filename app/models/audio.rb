class Audio < Medium
  store :meta_data, accessors: [:duration]
  validates :duration, presence: true

  def audio_url
    "#{self.identifier_url}.m4a"
  end
end
