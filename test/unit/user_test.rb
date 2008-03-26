require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  
  #fixtures :users, :schools, :disciplines_users, :courses
    
  def test_created_schools
    schools = @user1.created_schools
    expected_result = [@school1, @school2]
    assert_set_equal(expected_result, schools)
  end
  
  def test_created_courses
    courses = @user1.created_courses
    expected_result = [@course2, @course1]
    assert_set_equal(expected_result, courses)
  end

  def test_created_disciplines
    disciplines = @user1.created_disciplines
    expected_result = [@discipline1, @discipline2]
    assert_set_equal(expected_result, disciplines)
  end

  def test_get_disciplines
    disciplines = @user1.disciplines
    expected_result = [@discipline2, @discipline1]
    assert_set_equal(expected_result, disciplines)
  end

  def test_get_schools
    schools = @user1.schools
    expected_result = [@school1, @school2]
    assert_set_equal(expected_result, schools)
  end

  def test_get_courses
    courses = @user1.courses
    expected_result = [@course2, @course1]
    assert_set_equal(expected_result, courses)
  end

  def test_get_created_links
    expected_result = [@course_link1, @course_link2]
    assert_set_equal(expected_result, @user1.created_course_links)
  end

  # validation tests
  def test_validate_login_name
    u = User.new
    u.password = "abcdefgh"
    u.password_confirmation = "abcdefgh"
    # empty login name
    assert(!u.save)
    assert(u.errors["login"])

    # short login name
    u.login = "ss"
    assert(!u.save)
    assert(u.errors["login"])

    # long login name
    u.login = "longusername longusername longusername longusername longusername longusername longusername longusername longusername longusername longusername longusername longusername longusername longusername longusername longusername longusername longusername "
    assert(!u.save)
    assert(u.errors["login"])

    # invalid email format
    u.login = "test@test@.com"
    assert(!u.save)
    assert(u.errors["login"])

    #already existing email
    u.login = @user1.login
    assert(!u.save)
    assert(u.errors["login"])

    # valid email
    u.login = "test@test.com"
    assert(u.save)
  end

  def test_validate_password
    u = User.new
    u.login = "test@testdomain.com"
    
    # empty password test
    u.save
    assert(!u.save)
    assert(u.errors["password"])

    # short password test
    u.password = "abc"
    assert(!u.save)
    assert(u.errors["password"])

    # invalid confirmation
    u.password = "abcdefgh"
    u.password_confirmation = "abcdef"
    assert(!u.save)
    assert(u.errors["password"])

    # valid password
    u.password = "abcdefgh"
    u.password_confirmation = "abcdefgh"
    assert(u.save)
  end

  def test_security_token_on_create
    u = User.new
    u.login = "test@testdomain.com"
    u.password = "abcdefgh"
    u.password_confirmation = "abcdefgh"
    assert(u.save)
    assert(u.security_token)
    assert(u.token_expiry)
  end

  # update tests
  def test_update_user
    u = User.find 1
    old_password = u.salted_password
    u.login = "test@testdomain.com"
    assert(u.save)
    assert_equal(old_password, u.salted_password) # making sure that the password is not changed by updating login
  end
  
  # authentication tests
  def test_authenticate
    assert_equal(@user1, User.authenticate("user1@testdomain.com", "user1password"))
    assert_equal(nil, User.authenticate("user1@testdomain.com", "user1wrongpassword"))
  end

  # test change password
  def test_change_password
    @user1.password = "newpassword"
    @user1.password_confirmation = "newpassword1"
    assert(!@user1.save)

    @user1.password = "newpassword"
    @user1.password_confirmation = "newpassword"
    assert(@user1.save)

    assert_equal(nil, User.authenticate("user1@testdomain.com", "user1password"))
    assert_equal(nil, User.authenticate("user1@testdomain.com", "user1wrongpassword"))
  end
end
