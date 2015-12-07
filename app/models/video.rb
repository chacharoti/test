class Video < Medium
  def thumbnail_url
    "#{self.identifier_url}_thumbnail.jpg"
  end

  def video_url
    "#{self.identifier_url}.mp4"
  end
end
