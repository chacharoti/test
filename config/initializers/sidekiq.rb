require 'sidekiq/web'

if ENV['WEB_USERNAME'] && ENV['WEB_PASSWORD']
  Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
    [user, password] == [ENV['WEB_USERNAME'], ENV['WEB_PASSWORD']]
  end
end