require File.dirname(__FILE__) + '/../test_helper'

class DegreeTest < ActiveSupport::TestCase
  def test_get_creator
    assert_equal(@bob, @degree1.creator)  
  end

  def test_get_discipline
    assert_equal(@discipline1, @degree1.discipline)
  end

  def test_get_course_links
    expected_result = [@course_link1, @course_link2]
    assert_set_equal(expected_result, @degree1.course_links)
  end
end