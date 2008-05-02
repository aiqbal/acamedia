require File.dirname(__FILE__) + '/../test_helper'

class VotessTest < ActiveSupport::TestCase
  def test_get_user
    assert_equal(@user1, @vote1.user) 
  end
end
