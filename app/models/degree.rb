class Degree < ActiveRecord::Base
  @@levels = ["school", "high school", "undergrad", "graduate", "doctorate"]

  validates_presence_of :name, :short_name, :created_by

  def validate
    if self.level and !Degree.levels.index self.level
      errors.add(:level, "The level must be in #{Degree.levels.join(", ")}")
    end
  end

  belongs_to :discipline
  has_many :course_links
  belongs_to :creator, :foreign_key => :created_by, :class_name => "User"

  def self.levels
    @@levels
  end
end
