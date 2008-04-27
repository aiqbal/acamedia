require File.dirname(__FILE__) + '/../test_helper'

class SchoolCourseLinkTest < ActiveSupport::TestCase
  def test_get_course
    assert_equal(@course1, @school_course_link1.course)
  end

  def test_get_school
    assert_equal(@school1, @school_course_link1.school)
  end

  def test_get_creator
    assert_equal(@user1, @school_course_link1.creator)
  end

  def test_get_degree
    assert_equal(@degree1, @school_course_link1.degree)
  end

  def test_url_formatting
    cl = SchoolCourseLink.new
    cl.url = "chacha.com/page.html"
    cl.course = @course1
    cl.creator = @user1
    cl.school = @school1
    assert(cl.save)
    assert_equal("http://chacha.com/page.html", cl.url)
    assert_equal(@school1, cl.school)
  end

  def test_creates_school_on_save
    cl = SchoolCourseLink.new
    cl.url = "chacha.com/page.html"
    cl.creator = @user1
    cl.course = @course1
    assert(cl.save)
    assert(School.find_by_domain("chacha.com"))

    cl = SchoolCourseLink.new
    cl.url = "server1.school1.edu/page.html"
    cl.creator = @user1
    cl.course = @course1
    cl.school = @school1
    assert(cl.save)
    assert_equal(@school1, cl.school)
  end
  
  def test_get_thumbs
    c = @school_course_link1
    assert_equal([@thumb1], c.thumbs)
  end
  
  def test_add_thumb
    c = @school_course_link1
    t = c.add_thumb("1", @user2)
    assert_set_equal([@thumb1, t], c.thumbs)

    # make sure that a single cant add multiple thumbs for a single link
    t = c.add_thumb("0", @user2)
    assert_set_equal([@thumb1, t], c.thumbs)
  end
end
