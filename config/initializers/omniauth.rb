Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer, fields: [:id, :provider, :email, :name]
  provider :dbc, ENV['OAUTH_CLIENT_ID'], ENV['OAUTH_CLIENT_SECRET']
end
