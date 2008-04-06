class Course < ActiveRecord::Base
  validates_presence_of     :name, :description, :created_by
  validates_presence_of     :discipline, :message => "Discipline cant be empty"
  validates_uniqueness_of   :name
  validates_length_of       :name, :in => 3..255

  belongs_to :creator, :foreign_key => :created_by, :class_name => "User"
  belongs_to :discipline
  has_many :course_users
  has_many :users, :through => :course_users
  has_many :course_links
end
