require File.dirname(__FILE__) + '/../test_helper'

class CourseLinkTest < ActiveSupport::TestCase
  def test_get_course
    assert_equal(@course1, @course_link1.course)
  end

  def test_get_school
    assert_equal(@school1, @course_link1.school)
  end

  def test_get_creator
    assert_equal(@user1, @course_link1.creator)
  end

  def test_get_degree
    assert_equal(@degree1, @course_link1.degree)
  end

  def test_url_formatting
    cl = CourseLink.new
    cl.url = "chacha.com/page.html"
    cl.course = @course1
    cl.creator = @user1
    cl.school = @school1
    assert(cl.save)
    assert_equal("http://chacha.com/page.html", cl.url)
    assert_equal(@school1, cl.school)
  end

  def test_creates_school_on_save
    cl = CourseLink.new
    cl.url = "chacha.com/page.html"
    cl.creator = @user1
    cl.course = @course1
    assert(cl.save)
    assert(School.find_by_domain("chacha.com"))

    cl = CourseLink.new
    cl.url = "server1.school1.edu/page.html"
    cl.creator = @user1
    cl.course = @course1
    cl.school = @school1
    assert(cl.save)
    assert_equal(@school1, cl.school)
  end
end
