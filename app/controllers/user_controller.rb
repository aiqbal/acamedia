class UserController < ApplicationController
  layout 'scaffold'

  def signup
    if request.post?
      @user = User.new(params[:user])
      if @user.save
        flash[:notice] = "Please check your emails for email confirmation code,"
        redirect_to :action => 'authenticate'
      end
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
