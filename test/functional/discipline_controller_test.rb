require File.dirname(__FILE__) + '/../test_helper'

class DisciplineControllerTest < ActionController::TestCase
  include LoginHelper
  include MessageHelper

  def setup
    @controller = DisciplineController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_create_invalid_params
    post :create
    assert_redirected_to :action => :authenticate

    post_as_logged_in :create, @user1, {:discipline => {:name => "", :description => ""}}
    discipline = assigns(:discipline)
    assert(discipline.errors[:name])
    assert(discipline.errors[:description])
  end

  def test_create
    post_as_logged_in :create, @user1, {:discipline => {:name => "Test discipline name", :description => "Test disciplinedescription"}}
    assert_redirected_to :action => :view
    assert_equal get_msg("created_successfully"), flash[:notice]
    course = Discipline.find_by_name "Test discipline name"
    assert(course)
  end
  
end
