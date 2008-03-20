require File.dirname(__FILE__) + '/../test_helper'

class SchoolTest < ActiveSupport::TestCase
  def test_get_creator
    assert_equal(@bob, @school1.creator)
  end

  def test_get_users
    users = @school1.users
    expected_results = [@bob]
    assert_set_equal(expected_results, users)
  end

  def test_get_course_links
    expected_result = [@course_link1, @course_link2]
    assert_set_equal(expected_result, @school1.course_links)
  end

  def test_get_disciplines
    expected_result = [@discipline1, @discipline2]
    assert_set_equal(expected_result, @school1.disciplines)
  end

  def test_validation_checks
    s = School.new
    # empty params check
    assert(!s.save)
    assert(s.errors["name"])
    assert(s.errors["description"])
    assert(s.errors["created_by"])
    assert(s.errors["domain"])

    # name length
    s.name = "ab"
    assert(!s.save)
    assert(s.errors["name"])

    # invalid domain
    s.domain = "fdasfas"
    assert(!s.save)
    assert(s.errors["domain"])

    # already existing school
    s.domain = @school1.domain
    assert(!s.save)
    assert(s.errors["domain"])
  end

  def test_before_validation
    s = School.new
    s.name = "test name"
    s.description = "test description"
    s.created_by = @bob
    s.domain = "http://testschool.com"
    assert(s.save)
    assert_equal("testschool.com", s.domain)

    s.domain = "http://testschool.com/course1/course1.html"
    assert(s.save)
    assert_equal("testschool.com", s.domain)
  end
end
