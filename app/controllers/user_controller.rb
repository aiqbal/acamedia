class UserController < ApplicationController
  layout 'scaffold'
  before_filter :login_required, :except => [:signup, :authenticate, :confirm_email]

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
      redirect_to :action => "login"
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
    @user = get_session_user()
    if request.post?
      @user.new_password = nil
      @user.firstname = params[:user][:firstname]
      @user.lastname = params[:user][:lastname]
      if @user.save
        flash[:notice] = get_message('edit_user_successful')
        redirect_to :action => 'welcome'
      end
    end
  end

  def change_password
    if request.post?
      user = get_session_user
      user.password = params[:user][:password]
      user.password_confirmation = params[:user][:password_confirmation]
      if user.save
        flash[:notice] = get_message('change_password_successful')
      end
      user.password = user.password_confirmation = nil
    end
    redirect_to :action => :edit
  end

  def welcome
  end

  def logout
    session[:user] = nil
    flash[:notice] = get_message('logout_successful')
    redirect_to :action => :authenticate
  end
end
