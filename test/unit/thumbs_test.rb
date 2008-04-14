require File.dirname(__FILE__) + '/../test_helper'

class ThumbsTest < ActiveSupport::TestCase
  def test_get_user
    assert_equal(@user1, @thumb1.user) 
  end
end
