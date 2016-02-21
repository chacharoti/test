class DocumentsController < ApplicationController
  def create
    file_name = file.first
    file_extension = file.last
    render :json => {
      :policy => s3_upload_policy_document, 
      :signature => s3_upload_signature, 
      :key => "users/#{ get_user.unique_identifier }/photos/#{ file_name }_normal.#{ file_extension }", 
      :success_action_redirect => '/'
    }
  end

  def s3_confirm
    head :ok
  end

  private
  def s3_upload_policy_document
    Base64.encode64(
      {
        expiration: 30.minutes.from_now.utc.strftime('%Y-%m-%dT%H:%M:%S.000Z'),
        conditions: [
          { bucket: 'milispace-staging' },
          { acl: 'public-read' },
          ["starts-with", "$key", "users/"],
          { success_action_status: '201' }
        ]
      }.to_json
    ).gsub(/\n|\r/, '')
  end

  def s3_upload_signature
    Base64.encode64(
      OpenSSL::HMAC.digest(
        OpenSSL::Digest::Digest.new('sha1'),
        'gKxNRJGaBsHgJ10BRdl9xAMmzbYmw1V9MgWGJl60',
        s3_upload_policy_document
      )
    ).gsub(/\n/, '')
  end

  def user_id
    params[:user_id]
  end

  def get_user
    if user_id
      User.find user_id
    end
  end

  def file
    params[:doc][:title].split('.')
  end
end
