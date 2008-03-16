require File.dirname(__FILE__) + '/../test_helper'

class CourseTest < ActiveSupport::TestCase
  def test_get_creator
    creator = @course1.creator
    assert_equal(creator, @bob)
  end

  def test_get_users
    users = @course1.users
    expected_result = [@bob]
    assert_set_equal(expected_result, users)
  end

  def test_get_course_links
    expected_result = [@course_link1, @course_link2]
    assert_set_equal(expected_result, @course1.course_links)
  end
end
