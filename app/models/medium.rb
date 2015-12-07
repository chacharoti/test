class Medium < ActiveRecord::Base
  belongs_to :owner, polymorphic: true

  protected
  def identifier_url
    "#{AppSetting.media_url}#{self.file_key}"
  end
end
