class UserController < ApplicationController
  layout 'scaffold'

  def signup
    if request.post?
      @user = User.new(params[:user])
      if @user.save
        flash[:notice] = get_message('signup_completed')
        redirect_to :action => 'authenticate'
      end
    end
  end

  def confirm_email
    login = params[:user][:login]
    token = params[:user][:security_token]
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
  end

  def edit
  end

  def forgot_password
  end

  def welcome
  end
end
