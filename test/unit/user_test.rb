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
end
