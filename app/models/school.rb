class School < ActiveRecord::Base
  validates_presence_of     :name, :description, :created_by, :domain
  validates_uniqueness_of   :domain
  validates_length_of       :name, :in => 3..255
  validates_length_of       :domain, :in => 6..255
  validates_format_of       :domain, :with => /.+\..+/

  belongs_to :creator, :foreign_key => :created_by, :class_name => "User"
  has_many :school_users
  has_many :users, :through => :school_users
  has_many :course_links
  has_and_belongs_to_many :disciplines
  has_and_belongs_to_many :degrees

  def before_validation
    return unless self.domain
    self.domain.gsub!("http://", "")
    self.domain =~ /(www.)?([^\/]+).*/
    self.domain = $2 if $2
  end
end
