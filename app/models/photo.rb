class Photo < Medium
  store :meta_data, accessors: [:thumbnail_size, :normal_size]
  validates :thumbnail_size, presence: true
  validates :normal_size, presence: true

  def thumbnail_url
    "#{self.identifier_url}_thumbnail.jpg"
  end

  def normal_url
    "#{self.identifier_url}_normal.jpg"
  end
end
