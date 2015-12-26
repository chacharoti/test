class Medium < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  serialize :meta_data, Hash

  protected
  def identifier_url
    "#{AppSetting.media_url}#{self.file_key}"
  end
end
