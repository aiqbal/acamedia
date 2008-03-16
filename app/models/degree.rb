class Degree < ActiveRecord::Base
  belongs_to :discipline
  has_many :course_links
  belongs_to :creator, :foreign_key => :created_by, :class_name => "User"
end
