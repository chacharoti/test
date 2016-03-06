Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "1673785666169234", "2e8e7063946e832548074083a114e99c",
           {:scope => 'email', :info_fields => 'email,name,first_name,last_name,gender,birthday', :client_options => { :ssl => { :ca_file => "#{Rails.root}/config/ca-bundle.crt" }}}
end