require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  
  #fixtures :users, :schools, :disciplines_users, :courses
    
  def test_created_schools
    schools = @bob.created_schools
    expected_result = [@school1, @school2]
    assert_set_equal(expected_result, schools)
  end
  
  def test_created_courses
    courses = @bob.created_courses
    expected_result = [@course2, @course1]
    assert_set_equal(expected_result, courses)
  end

  def test_created_disciplines
    disciplines = @bob.created_disciplines
    expected_result = [@discipline1, @discipline2]
    assert_set_equal(expected_result, disciplines)
  end

  def test_get_disciplines
    disciplines = @bob.disciplines
    expected_result = [@discipline2, @discipline1]
    assert_set_equal(expected_result, disciplines)
  end

  def test_get_schools
    schools = @bob.schools
    expected_result = [@school1, @school2]
    assert_set_equal(expected_result, schools)
  end

  def test_get_courses
    courses = @bob.courses
    expected_result = [@course2, @course1]
    assert_set_equal(expected_result, courses)
  end

  def test_get_created_links
    expected_result = [@course_link1, @course_link2]
    assert_set_equal(expected_result, @bob.created_course_links)
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

  # update tests
  def test_update_user
    u = User.find 1000001
    old_password = u.salted_password
    u.login = "test@testdomain.com"
    assert(u.save)
    assert_equal(old_password, u.salted_password) # making sure that the password is not changed by updating login
  end
  
  # authentication tests
  def test_authenticate
    u = User.new
    u.login = "test@testdomain.com"
    u.password = "testpassword"
    u.verified = 1
    assert(u.save)
    assert_equal(u, User.authenticate("test@testdomain.com", "testpassword"))
    assert_equal(nil, User.authenticate("test@testdomain.com", "wrong password"))
  end
end
