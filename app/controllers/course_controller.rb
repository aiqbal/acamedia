class CourseController < ApplicationController
  layout 'scaffold'
  before_filter :login_required, :except => :view

  def view
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
    @disciplines = Discipline.find(:all, :order => "name" ).map {|d| [d.name, d.id] }
  end

  def edit
  end
end
