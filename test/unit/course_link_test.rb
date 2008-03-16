require File.dirname(__FILE__) + '/../test_helper'

class CourseLinkTest < ActiveSupport::TestCase
  def test_get_course
    assert_equal(@course1, @course_link1.course)
  end

  def test_get_school
    assert_equal(@school1, @course_link1.school)
  end

  def test_get_creator
    assert_equal(@bob, @course_link1.creator)
  end

  def test_get_degree
    assert_equal(@degree1, @course_link1.degree)
  end
end
