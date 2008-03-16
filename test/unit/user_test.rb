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

  # Authentication test cases
  def test_auth
    
    assert_nil User.authenticate("nonbob", "atest")
    assert_equal  @bob, User.authenticate("bob@test.com", "atest")    

  end


  def test_passwordchange
        
    @longbob.change_password("nonbobpasswd")
    @longbob.save
    assert_equal @longbob, User.authenticate("longbob@test.com", "nonbobpasswd")
    assert_nil User.authenticate("longbob@test.com", "alongtest")
    @longbob.change_password("alongtest")
    @longbob.save
    assert_equal @longbob, User.authenticate("longbob@test.com", "alongtest")
    assert_nil User.authenticate("longbob@test.com", "nonbobpasswd")
        
  end
  
  def test_disallowed_passwords
    
    u = User.new    
    u.login = "nonbob"

    u.change_password("tiny")
    assert !u.save     
    assert u.errors.invalid?('password')

    u.change_password("hugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehuge")
    assert !u.save     
    assert u.errors.invalid?('password')
        
    u.change_password("")
    assert !u.save    
    assert u.errors.invalid?('password')
        
    u.change_password("bobs_secure_password")
    assert u.save     
    assert u.errors.empty?
        
  end
  
  def test_bad_logins

    u = User.new  
    u.change_password("bobs_secure_password")

    u.login = "x"
    assert !u.save     
    assert u.errors.invalid?('login')
    
    u.login = "hugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhug"
    assert !u.save     
    assert u.errors.invalid?('login')

    u.login = ""
    assert !u.save
    assert u.errors.invalid?('login')

    u.login = "okbob"
    assert u.save  
    assert u.errors.empty?
      
  end


  def test_collision
    u = User.new
    u.login = "existingbob@test.com"
    u.change_password("bobs_secure_password")
    assert !u.save
  end


  def test_create
    u = User.new
    u.login = "nonexistingbob"
    u.change_password("bobs_secure_password")
      
    assert u.save  
    
  end
  
end
