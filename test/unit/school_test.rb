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
end
