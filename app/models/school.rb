class School < ActiveRecord::Base
  belongs_to :creator, :foreign_key => :created_by, :class_name => "User"
  has_many :school_users
  has_many :users, :through => :school_users
  has_many :course_links
  has_and_belongs_to_many :disciplines
end
