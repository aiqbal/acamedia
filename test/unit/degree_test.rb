require File.dirname(__FILE__) + '/../test_helper'

class DegreeTest < ActiveSupport::TestCase
  def test_get_creator
    assert_equal(@user1, @degree1.creator)  
  end

  def test_get_discipline
    assert_equal(@discipline1, @degree1.discipline)
  end

  def test_get_course_links
    expected_result = [@course_link1, @course_link2]
    assert_set_equal(expected_result, @degree1.course_links)
  end

  def test_validation_checks
    d = Degree.new
    assert(!d.save)
    assert(d.errors["name"])
    assert(d.errors["short_name"])
    assert(d.errors["created_by"])

    # level value test
    d.name = "test name"
    d.short_name = "test nm"
    d.level = "wrong level"
    d.created_by = @user1
    assert(!d.save)
    assert(d.errors["level"])
  end

end
