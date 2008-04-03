require File.dirname(__FILE__) + '/../test_helper'

class UserControllerTest < ActionController::TestCase
  include LoginHelper
  # Replace this with your real tests.
  def setup
    @controller = UserController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def get_msg(msg_id)
    expected_message = get_message(msg_id, @controller.controller_name)
  end

  def test_signup_invalid_params
    #invalid username and missing password
    post :signup, {:user => {:login => ''}}
    user = assigns(:user)
    assert_response 200
    assert(user.errors)

    #missing confirmation password
    post :signup, {:user => {:login => 'test@testdomain.com', :password => "testpassword", :password_confirmation => "fasdsa"}}
    user = assigns(:user)
    assert_response 200
    assert(user.errors)
  end

  def test_singup_valid_params
    post :signup, {:user => {:login => 'test@testdomain.com', :password => "testpassword", :password_confirmation => "testpassword"}}
    assert_redirected_to :action => "authenticate"
    assert_equal get_msg("signup_completed"), flash[:notice]
    assert_equal 1, ActionMailer::Base.deliveries.size
    mail = ActionMailer::Base.deliveries[0]
    assert_equal "test@testdomain.com", mail.to_addrs[0].to_s
  end

  def test_verify_user_invalid_params
    get :confirm_email, {:login => @user2.login, :security_token => "invalid token"}
    assert_redirected_to :action => "signup"
    assert_equal get_msg("invalid_email_confirmation"), flash[:notice]

    u = User.find_by_login @user2.login
    assert_equal(false, u.verified)
  end

  def test_verify_user
    get :confirm_email, :login => @user2.login, :security_token => @user2.security_token
    assert_redirected_to :action => "welcome"
    assert_equal get_msg("email_confirmed"), flash[:notice]

    u = User.find_by_login @user2.login
    assert_equal(true, u.verified)
  end

  def test_invalid_authenticate
    post :authenticate, {:user => {:login => @user1.login, :password => "invalid_password"}}
    assert_equal get_msg("authentication_failed"), flash[:error]
    assert !session[:user]

    post :authenticate, {:user => {:login => @user2.login, :password => "user2password"}}
    assert_equal get_msg("authentication_failed"), flash[:error]
    assert !session[:user]
  end

  def test_authenticate
    post :authenticate, {:user => {:login => @user1.login, :password => "user1password"}}
    assert_redirected_to :action => "welcome"
    assert_equal get_msg("authentication_successful"), flash[:notice]
    assert_equal(@user1, session[:user])
  end

  def test_before_filters
    get :welcome
    assert_redirected_to :action => :authenticate
    
    get_as_logged_in :welcome
    assert_response 200
  end

end
