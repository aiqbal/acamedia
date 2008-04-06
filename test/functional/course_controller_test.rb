require File.dirname(__FILE__) + '/../test_helper'

class CourseControllerTest < ActionController::TestCase
  include LoginHelper
  include MessageHelper

  def setup
    @controller = CourseController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_create_invalid_params
    post :create
    assert_redirected_to :action => :authenticate

    post_as_logged_in :create, @user1, {:course => {:name => "", :description => "", :discipline_id => ""}}
    course = assigns(:course)
    assert(course.errors[:name])
    assert(course.errors[:description])
    assert(course.errors[:discipline])
  end

  def test_create
    post_as_logged_in :create, @user1, {:course => {:name => "Test course name", :description => "Test course description", :discipline_id => @discipline1.id}}
    assert_redirected_to :action => :view
    assert_equal get_msg("created_successfully"), flash[:notice]
    course = Course.find_by_name "Test course name"
    assert(course)
  end
end
