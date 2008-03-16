class Discipline < ActiveRecord::Base
  belongs_to :creator, :foreign_key => :created_by, :class_name => "User"
  has_many :degrees
  has_and_belongs_to_many :users
  has_and_belongs_to_many :schools
end
