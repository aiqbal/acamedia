require File.dirname(__FILE__) + '/../test_helper'

class DisciplineTest < ActiveSupport::TestCase
  def test_get_creator
    creator = @discipline1.creator
    assert_equal(creator, @bob)
  end

  def test_get_users
    users = @discipline1.users
    expected_result = [@bob]
    assert_set_equal(expected_result, users)
  end

  def test_get_schools
    expected_result = [@school1]
    assert_set_equal(expected_result, @discipline1.schools)
  end
end
