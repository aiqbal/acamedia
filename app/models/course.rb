class Course < ActiveRecord::Base
  belongs_to :creator, :foreign_key => :created_by, :class_name => "User"
  has_many :course_users
  has_many :users, :through => :course_users
  has_many :course_links
end
