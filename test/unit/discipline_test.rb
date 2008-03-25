require File.dirname(__FILE__) + '/../test_helper'

class DisciplineTest < ActiveSupport::TestCase
  def test_get_creator
    creator = @discipline1.creator
    assert_equal(creator, @user1)
  end

  def test_get_users
    users = @discipline1.users
    expected_result = [@user1]
    assert_set_equal(expected_result, users)
  end

  def test_get_schools
    expected_result = [@school1]
    assert_set_equal(expected_result, @discipline1.schools)
  end

  def test_get_degrees
    expected_result = [@degree1, @degree2]
    assert_set_equal(expected_result, @discipline1.degrees)
  end

  def test_validation_checks
    d = Discipline.new
    # empty params check
    assert(!d.save)
    assert(d.errors["name"])
    assert(d.errors["description"])
    assert(d.errors["created_by"])

    # name length
    d.name = "ab"
    assert(!d.save)
    assert(d.errors["name"])

    # name uniqueness test
    d.name = @discipline1.name
    assert(!d.save)
    assert(d.errors["name"])
  end
end
