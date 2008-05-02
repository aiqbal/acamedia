class SchoolCourseLink < ActiveRecord::Base
  include ThumbHelper
  include OnlineResourceHelper

  validates_presence_of     :school_id, :created_by, :course_id, :url
  validates_format_of       :url, :with => /^http(s)?:\/\/[\w\-\.]+\.[\w\-\.\/]+$/
  validates_uniqueness_of   :url

  belongs_to :course
  belongs_to :school
  belongs_to :creator, :foreign_key => :created_by, :class_name => "User"
  belongs_to :degree

  before_validation :normalize_url, :create_school

  def normalize_url
    return unless self.url
    unless self.url =~ /http(s)?:\/\/.+\..+/
      self.url = "http://" + self.url
    end
  end

  def create_school
    return if self.school or !self.creator
    domain = School.url_to_domain(self.url)
    school = School.find_by_domain(domain)
    unless school
      school = School.new
      school.domain = school.name = school.description = domain
      school.creator = self.creator
      school.save
    end
    self.school = school
  end
end
