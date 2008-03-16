class School < ActiveRecord::Base
  belongs_to :creator, :foreign_key => :created_by, :class_name => "User"
  has_many :school_users
  has_many :users, :through => :school_users
  has_many :course_links
end
