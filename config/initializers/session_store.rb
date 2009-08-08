# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_SystemsHQ_session',
  :secret      => 'cb305790a37947cd21f9878bdd9db42153573170befa8d7ad0d704688d139722e85737b7003f31cf7e03a3e2815fb294e1330927bb0bff6690d56abb4f2d93fb'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
