# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_tropo_cloud1_session',
  :secret      => '0f6456f0d16504ec7143fefc597eba3fdf26b259a8d1530a7c25371d2e20d07ab9cad0acec1192c5f880011c623c510990a51710038a5988ee9cc6c5a38e0548'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
