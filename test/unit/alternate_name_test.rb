require File.dirname(__FILE__) + '/../test_helper'

class AlternateNameTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def test_truth
    assert_equal(@user1,@alternate_name1.user) 
    assert_equal(@course1,@alternate_name1.get_original_object())
    assert_equal(@course2,@alternate_name3.get_original_object())
  end
end
