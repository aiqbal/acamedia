require File.dirname(__FILE__) + '/../test_helper'

class CourseTest < ActiveSupport::TestCase
  def test_get_creator
    creator = @course1.creator
    assert_equal(creator, @user1)
  end

  def test_get_users
    users = @course1.users
    expected_result = [@user1]
    assert_set_equal(expected_result, users)
  end

  def test_get_course_links
    expected_result = [@course_link1, @course_link2]
    assert_set_equal(expected_result, @course1.course_links)
  end
  
  def test_get_discipline
    assert_equal @discipline1, @course1.discipline
  end

  def test_validation_checks
    c = Course.new
    # empty params check
    assert(!c.save)
    assert(c.errors["name"])
    assert(c.errors["description"])
    assert(c.errors["created_by"])
    assert(c.errors["discipline"])

    # name length
    c.name = "ab"
    assert(!c.save)
    assert(c.errors["name"])

    # name uniqueness test
    c = Course.new
    c.name = @course1.name
    assert(!c.save)
    assert(c.errors["name"])

    # valid save
    c.name = "New course"
    c.discipline = @discipline1
    c.description = "New course description"
    c.created_by = @user1
    assert(c.save)
  end

end
