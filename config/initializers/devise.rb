Devise.setup do |config|
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
  config.secret_key = '9632577a55f19de0afa25edc9ff042c4d1f9ade7a3e1918a677f019019b4e0a1fcdbc9d9f8df33ed1cf991e628ab8b6326f0208eaa0475bbf0f5ba3eb3caceb1'

  
  require 'devise/orm/active_record'
  # config.omniauth :facebook, "1706728072946891", "cd061e64e313ff5705c7c181359f00a4", scope: 'email', info_fields: 'email'
  config.omniauth :facebook, "1658392347776651", "cdbfa770af755e13737c395478e236b9", scope: 'email', info_fields: 'email'


  require 'omniauth-google-oauth2'
  config.omniauth :google_oauth2, "1021292264429-ib6flbeeutir6m3v71sdourullakpitt.apps.googleusercontent.com", "eisudZxBU0d3I1WDBx3mztc5", {:scope => "email, profile", :prompt => 'consent'}

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 8..72
  config.reset_password_within = 6.hours
  config.scoped_views = true
  config.sign_out_via = :delete
end