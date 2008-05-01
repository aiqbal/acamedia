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

  def test_add_link_invalid_params
    post :add_link
    assert_redirected_to :action => :authenticate

    post_as_logged_in :add_link, @user1, {:school_course_link => {:url => "fadsfas"}}
    #assert_equal(get_msg('add_link_invalid_url'), flash[:add_link_notice])
    course_link = assigns(:school_course_link)
    assert(course_link.errors[:url])
    assert_redirected_to :action => :view

    post_as_logged_in :add_link, @user1, {:school_course_link => {:url => "nu.edu.pk/test.html", :course_id => @course1.id}}
    course_link = assigns(:school_course_link)
    assert(course_link)
    #assert_equal(get_msg('add_link_success'), flash[:add_link_notice])
    course_link = SchoolCourseLink.find_by_url('http://nu.edu.pk/test.html')
    school = School.find_by_domain('nu.edu.pk')
    assert(course_link)
    assert(school) # making sure that the school is created on adding a url
  end
end
