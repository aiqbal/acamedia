class UserController < ApplicationController
  layout 'scaffold'

  def signup
    if request.post?
      @user = User.new(params[:user])
      if @user.save
        confirmation_url = url_for :action => :confirm_email, :login => @user.login, :security_token => @user.security_token
        UserNotify.deliver_signup(@user, confirmation_url)
        flash[:notice] = get_message('signup_completed')
        redirect_to :action => 'authenticate'
      end
    end
  end

  def confirm_email
    login = params[:login]
    token = params[:security_token]
    u = User.verify_login(login, token)
    if u
      flash[:notice] = get_message('email_confirmed')
      redirect_to :action => "welcome"
    else
      flash[:notice] = get_message('invalid_email_confirmation')
      redirect_to :action => "signup"
    end
  end

  def authenticate
    if request.post?
      @user = User.new(params[:user])
      if user = User.authenticate(@user.login, @user.password)
        set_session_user(user)
        flash[:notice] = get_message('authentication_successful')
        redirect_to :action => 'welcome'
      else
        flash[:error] = get_message('authentication_failed')
      end
    end
  end

  def edit
  end

  def forgot_password
  end

  def welcome
  end
end
