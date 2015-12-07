class Photo < Medium
  def thumbnail_url
    "#{self.identifier_url}_thumbnail.jpg"
  end

  def normal_url
    "#{self.identifier_url}_normal.jpg"
  end
end
