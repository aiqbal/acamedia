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
end
