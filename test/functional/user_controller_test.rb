require File.dirname(__FILE__) + '/../test_helper'
require 'user_controller'
# ADD to fix advance_by_days= problem
#require File.dirname(__FILE__) + '/../mocks/test/time'

# Raise errors beyond the default web-based presentation
class UserController; def rescue_action(e) raise e end; end

class UserControllerTest < Test::Unit::TestCase
  
  fixtures :users

  def setup
    super
    @controller = UserController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end
  
  def test_auth_bob
    @request.session['return-to'] = "/bogus/location"

    post :login, "user" => { "login" => "bob@test.com", "password" => "atest" }
    assert_not_nil @response.session["user"]

    assert_equal @bob, @response.session["user"]
    
    assert_equal("http://#{@request.host}/bogus/location", @response.redirect_url)
  end
  
  def do_test_signup(bad_password, bad_email)
    ActionMailer::Base.deliveries = []

    @request.session['return-to'] = "/bogus/location"

    if not bad_password and not bad_email
      post :signup, "user" => { "login" => "newbob@test.com", "password" => "newpassword", "password_confirmation" => "newpassword" }
      assert_nil session["user"]

      assert_equal(@controller.url_for(:action => "login"), @response.redirect_url)
      assert_equal 1, ActionMailer::Base.deliveries.size
      mail = ActionMailer::Base.deliveries[0]
      assert_equal "newbob@test.com", mail.to_addrs[0].to_s
      mail.encoded =~ /key=(.*?)"/
      key = $1

      user = User.find_by_login("newbob@test.com")
      assert_not_nil user
      assert_equal 0, user.verified

      # First past the expiration.
      #Time.advance_by_days = 1
      get :welcome, "user"=> { "id" => "#{user.id}" }, "key" => "#{key}"
      #Time.advance_by_days = 0
      user = User.find_by_login("newbob@test.com")
      #assert_equal 0, user.verified

      # Then a bogus key.
      get :welcome, "user"=> { "id" => "#{user.id}" }, "key" => "boguskey"
      user = User.find_by_login("newbob@test.com")
      #assert_equal 0, user.verified

      # Now the real one.
      get :welcome, "user"=> { "id" => "#{user.id}" }, "key" => "#{key}"
      user = User.find_by_login("newbob@test.com")
      #assert_equal 1, user.verified

      post :login, "user" => { "login" => "newbob@test.com", "password" => "newpassword" }
      assert_not_nil session["user"]
      get :logout
    elsif bad_password
      post :signup, "user" => { "login" => "newbob@test.com", "password" => "bad", "password_confirmation" => "bad"}
      assert_nil session["user"]
      assert(find_record_in_template("user").errors.invalid?(:password))

      assert_response(:success)
      assert_equal 0, ActionMailer::Base.deliveries.size
    elsif bad_email
      ActionMailer::Base.inject_one_error = true
      post :signup, "user" => { "login" => "newbob@test.com", "password" => "newpassword", "password_confirmation" => "newpassword" }
      assert_nil session["user"]
      assert_equal 0, ActionMailer::Base.deliveries.size
    else
      # Invalid test case
      assert false
    end
  end
  
  def test_edit
    post :login, "user" => { "login" => "bob@test.com", "password" => "atest" }
    assert_not_nil session["user"]

    post :edit, "user" => { "firstname" => "Bob", "form" => "edit" }
    assert_equal @response.session["user"].firstname, "Bob"

    post :edit, "user" => { "firstname" => "", "form" => "edit" }
    assert_equal @response.session["user"].firstname, ""

    get :logout
  end

  def test_delete
    ActionMailer::Base.deliveries = []

    # Immediate delete
    post :login, "user" => { "login" => "deletebob1@test.com", "password" => "alongtest" }
    assert_not_nil session["user"]

    UserSystem::CONFIG[:delayed_delete] = false
    post :edit, "user" => { "form" => "delete" }
    assert_equal 1, ActionMailer::Base.deliveries.size

    assert_nil session["user"]
    post :login, "user" => { "login" => "deletebob1@test.com", "password" => "alongtest" }
    assert_nil session["user"]

    # Now try delayed delete
    ActionMailer::Base.deliveries = []

    post :login, "user" => { "login" => "deletebob2@test.com", "password" => "alongtest" }
    assert_not_nil session["user"]

    UserSystem::CONFIG[:delayed_delete] = true
    post :edit, "user" => { "form" => "delete" }
    assert_equal 1, ActionMailer::Base.deliveries.size
    mail = ActionMailer::Base.deliveries[0]
    mail.encoded =~ /user\[id\]=(.*?)&key=(.*?)"/
    id = $1
    key = $2
    post :restore_deleted, "user" => { "id" => "#{id}" }, "key" => "badkey"
    assert_nil session["user"]

    # Advance the time past the delete date
    #Time.advance_by_days = UserSystem::CONFIG[:delayed_delete_days]
    post :restore_deleted, "user" => { "id" => "#{id}" }, "key" => "#{key}"
    #assert_nil session["user"]

    #Time.advance_by_days = 0
    post :restore_deleted, "user" => { "id" => "#{id}" }, "key" => "#{key}"
    assert_not_nil session["user"]
    get :logout
  end

  def test_signup
    do_test_signup(true, false)
    do_test_signup(false, true)
    do_test_signup(false, false)
  end

  def do_change_password(bad_password, bad_email)
    ActionMailer::Base.deliveries = []

    post :login, "user" => { "login" => "bob@test.com", "password" => "atest" }
    assert_not_nil session["user"]

    if not bad_password and not bad_email
      post :change_password, "user" => { "password" => "changed_password", "password_confirmation" => "changed_password" }
      assert_equal 1, ActionMailer::Base.deliveries.size
      mail = ActionMailer::Base.deliveries[0]
      assert_equal "bob@test.com", mail.to_addrs[0].to_s
#      assert_match /login:\s+\w+\n/, mail.encoded
#      assert_match /password:\s+\w+\n/, mail.encoded
    elsif bad_password
      post :change_password, "user" => { "password" => "bad", "password_confirmation" => "bad" }
      assert(find_record_in_template("user").errors.invalid?(:password))
      assert_response(:success)
      assert_equal 0, ActionMailer::Base.deliveries.size
    elsif bad_email
      ActionMailer::Base.inject_one_error = true
      post :change_password, "user" => { "password" => "changed_password", "password_confirmation" => "changed_password" }
      assert_equal 0, ActionMailer::Base.deliveries.size
    else
      # Invalid test case
      assert false
    end

    get :logout
    assert_nil session["user"]

    if not bad_password and not bad_email
      post :login, "user" => { "login" => "bob@test.com", "password" => "changed_password" }
      assert_not_nil session["user"]
      post :change_password, "user" => { "password" => "atest", "password_confirmation" => "atest" }
      get :logout
    end

    post :login, "user" => { "login" => "bob@test.com", "password" => "atest" }
    assert_not_nil session["user"]

    get :logout
  end

  def test_change_password0
    do_change_password(false, false)
  end
  def test_change_password1
    do_change_password(true, false)
  end
  def test_change_password2
    do_change_password(false, true)
  end

  def do_forgot_password(bad_address, bad_email, logged_in)
    ActionMailer::Base.deliveries = []

    if logged_in
      post :login, "user" => { "login" => "bob@test.com", "password" => "atest" }
      assert_not_nil session["user"]
    end

    @request.session['return-to'] = "/bogus/location"
    if not bad_address and not bad_email
      post :forgot_password, "user" => { "login" => "bob@test.com" }
      password = "anewpassword"
      if logged_in
        assert_equal 0, ActionMailer::Base.deliveries.size
        assert_equal(@controller.url_for(:action => "change_password"), @response.redirect_url)
        post :change_password, "user" => { "password" => "#{password}", "password_confirmation" => "#{password}" }
      else
        assert_equal 1, ActionMailer::Base.deliveries.size
        mail = ActionMailer::Base.deliveries[0]
        assert_equal "bob@test.com", mail.to_addrs[0].to_s
        mail.encoded =~ /user\[id\]=(.*?)&key=(.*?)"/
        id = $1
        key = $2
        post :change_password, "user" => { "password" => "#{password}", "password_confirmation" => "#{password}", "id" => "#{id}" }, "key" => "#{key}"
        assert_not_nil session["user"]
        get :logout
      end
    elsif bad_address
      post :forgot_password, "user" => { "login" => "bademail@test.com" }
      assert_equal 0, ActionMailer::Base.deliveries.size
    elsif bad_email
      ActionMailer::Base.inject_one_error = true
      post :forgot_password, "user" => { "login" => "bob@test.com" }
      assert_equal 0, ActionMailer::Base.deliveries.size
    else
      # Invalid test case
      assert false
    end

    if not bad_address and not bad_email
      if logged_in
        get :logout
      else
        assert_equal(@controller.url_for(:action => "login"), @response.redirect_url)
      end
      post :login, "user" => { "login" => "bob@test.com", "password" => "#{password}" }
    else
      # Okay, make sure the database did not get changed
      if logged_in
        get :logout
      end
      post :login, "user" => { "login" => "bob@test.com", "password" => "atest" }
    end

    assert_not_nil session["user"]

    # Put the old settings back
    if not bad_address and not bad_email
      post :change_password, "user" => { "password" => "atest", "password_confirmation" => "atest" }
    end
    
    get :logout
  end

  def test_forgot_password
    do_forgot_password(false, false, false)
    do_forgot_password(false, false, true)
    do_forgot_password(true, false, false)
    do_forgot_password(false, true, false)
  end

  def test_bad_signup
    @request.session['return-to'] = "/bogus/location"

    post :signup, "user" => { "login" => "newbob@test.com", "password" => "newpassword", "password_confirmation" => "wrong" }
    assert(find_record_in_template("user").errors.invalid?(:password))
    assert_response(:success)

    post :signup, "user" => { "login" => "yo", "password" => "newpassword", "password_confirmation" => "newpassword" }
    assert(find_record_in_template("user").errors.invalid?(:login))
    assert_response(:success)

    post :signup, "user" => { "login" => "yo", "password" => "newpassword", "password_confirmation" => "wrong" }
    assert(find_record_in_template("user").errors.invalid?(:login))
    assert(find_record_in_template("user").errors.invalid?(:password))
    assert_response(:success)
  end

  def test_invalid_login
    post :login, "user" => { "login" => "bob@test.com", "password" => "not_correct" }
     
    assert_nil session["user"]
    
    assert(@response.has_template_object?("login"))
  end
  
  def test_login_logoff

    post :login, "user" => { "login" => "bob@test.com", "password" => "atest" }
    assert_not_nil session["user"]

    get :logout
    assert_nil session["user"]

  end

  # deprecated assertions
  def find_record_in_template(key = nil)
    assert_not_nil assigns(key)
    record = @response.template_objects[key]
    
    assert_not_nil(record)
    assert_kind_of ActiveRecord::Base, record
    
    return record
  end  
end
