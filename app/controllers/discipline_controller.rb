class DisciplineController < ApplicationController
  layout 'main'
  def create
    if request.post?
      @discipline = Discipline.new(params[:discipline])
      @discipline.creator = get_session_user
      if @discipline.save
        flash[:notice] = get_message('created_successfully')
        redirect_to :action => 'view', :id => @discipline.name
      end
    end
  end

  def view
    @discipline = Discipline.find_by_name(params[:id])
  end

  def update
  end
end
