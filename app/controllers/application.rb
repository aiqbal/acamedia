# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'environment.rb'

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '95442c39660c360ca349c01db37ee90b'

  def login_required
    unless session[:user]
      redirect_to :controller => :user, :action => :authenticate
    end
  end

  def get_message(message_name)
    Messages.get_message(message_name, self.controller_name)
  end
end
