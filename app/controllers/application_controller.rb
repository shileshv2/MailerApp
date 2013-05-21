# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  #protect_from_forgery # See ActionController::RequestForgeryProtection for details
  "protect_from_forgery # :secret => '9847618af6620f8564a5f7ef12f48a5a" 
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def initialize_tinymce
    #Link to tinymce used: https://github.com/trevorrowe/tinymce_hammer/
    initialize_tinymce_with 'tinymce_for_text_message.rb'
  end

  def initialize_tinymce_with(file)
    eval File.open(Rails.root.join('config','initializers',file)).read
  end
  
end
