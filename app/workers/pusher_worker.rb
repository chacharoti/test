class PusherWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(channels, event, message)
    begin
      pusher_client = Pusher::Client.new(app_id: ENV['PUSHER_APP_ID'], key: ENV['PUSHER_KEY'], secret: ENV['PUSHER_SECRET'] )
      pusher_client.trigger(channels, event, message)
    rescue Exception => e
      AlertMailer.system_alert(e.to_s, "pusher: #{channels} - #{event} - #{message} crash").deliver
    end
  end
end
