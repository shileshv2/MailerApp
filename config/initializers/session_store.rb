# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mailerApp_session',
  :secret      => '642f859afdef07b9541977f0e4bd6f64c85de01dbe4804188bf75a7b9a602c07ecbbeb9e9f4bdf5d75d8e93ca0cc4b3aae55ef77d2dec449fff94137bcdb0316'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
