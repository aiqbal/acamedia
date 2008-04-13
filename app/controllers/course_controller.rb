class CourseController < ApplicationController
  layout 'scaffold'
  before_filter :login_required, :except => :view

  def view
    @course = Course.find_by_name(params[:id])
  end

  def create
    if request.post?
      @course = Course.new(params[:course])
      @course.creator = get_session_user
      if @course.save
        flash[:notice] = get_message('created_successfully')
        redirect_to :action => 'view', :id => @course.name
      end
    else
    end
    @disciplines = Discipline.get_sorted_disciplines
  end

  def add_link
    if request.post?
      @course_link = CourseLink.new(params[:course_link])
      @course_link.creator = get_session_user
      if @course_link.save
        flash[:add_link_notice] = get_message('add_link_success')
      elsif @course_link.errors['url']
        flash[:add_link_notice] = get_message('add_link_invalid_url')
      else
        flash[:add_link_notice] = get_message('add_link_failure')
      end
    end
    redirect_to :action => :view, :id => params[:id]
  end

  def edit
  end
end
