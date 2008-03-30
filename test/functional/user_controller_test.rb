require File.dirname(__FILE__) + '/../test_helper'

class UserControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  def setup
    @controller = UserController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
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
  end

  def test_verify_user_invalid_params
    get :confirm_email, {:user => {:login => @user2.login, :security_token => "invalid token"}}
    assert_redirected_to :action => "signup"
    u = User.find_by_login @user2.login
    assert_equal(false, u.verified)
  end

  def test_verify_user
    get :confirm_email, {:user => {:login => @user2.login, :security_token => @user2.security_token}}
    assert_redirected_to :action => "welcome"
    u = User.find_by_login @user2.login
    assert_equal(true, u.verified)
  end

end
