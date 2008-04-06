class Discipline < ActiveRecord::Base
  validates_presence_of     :name, :description, :created_by
  validates_uniqueness_of   :name
  validates_length_of       :name, :in => 3..255

  belongs_to :creator, :foreign_key => :created_by, :class_name => "User"
  has_many :degrees
  has_many :courses
  has_and_belongs_to_many :users
  has_and_belongs_to_many :schools
end
