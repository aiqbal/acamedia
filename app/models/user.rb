require 'digest/sha1'

# this model expects a certain database layout and its based on the name/login pattern. 
class User < ActiveRecord::Base

  has_many :created_schools,      :foreign_key => :created_by, :class_name => "School"
  has_many :created_courses,      :foreign_key => :created_by, :class_name => "Course"
  has_many :created_disciplines,  :foreign_key => :created_by, :class_name => "Discipline"
  has_many :created_course_links, :foreign_key => :created_by, :class_name => "CourseLink"
  has_many :created_degrees,      :foreign_key => :created_by, :class_name => "Degree"
  
  has_and_belongs_to_many :disciplines
  has_many :school_users
  has_many :schools, :through => :school_users
  has_many :course_users
  has_many :courses, :through => :course_users
  
end
