# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'localization' 
require 'user_system'
require 'environment.rb'

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include Localization
  include UserSystem
  require_dependency 'user'

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '95442c39660c360ca349c01db37ee90b'
end
