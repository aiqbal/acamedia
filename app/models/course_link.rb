class CourseLink < ActiveRecord::Base
  belongs_to :course
  belongs_to :school
  belongs_to :creator, :foreign_key => :created_by, :class_name => "User"
end
