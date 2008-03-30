require 'digest/sha1'

# this model expects a certain database layout and its based on the name/login pattern. 
class User < ActiveRecord::Base
protected
  EXPIRE_AFTER_DAYS = 7

  has_many :created_schools,      :foreign_key => :created_by, :class_name => "School"
  has_many :created_courses,      :foreign_key => :created_by, :class_name => "Course"
  has_many :created_disciplines,  :foreign_key => :created_by, :class_name => "Discipline"
  has_many :created_course_links, :foreign_key => :created_by, :class_name => "CourseLink"
  has_many :created_degrees,      :foreign_key => :created_by, :class_name => "Degree"
  
  has_and_belongs_to_many :disciplines
  has_many :school_users
  has_many :schools, :through => :school_users
  has_many :course_users
  has_many :courses, :through => :course_users

  validates_presence_of     :login
  validates_length_of       :login, :in => 3..80
  validates_presence_of     :password, :if => :validate_password?
  validates_confirmation_of :password, :if => :validate_password?
  validates_length_of       :password, {:in => 6..40, :if => :validate_password?}
  validates_format_of       :login, :with => /^[^@]+@[^@]+\.[^@]+$/, :message => "is not a valid email address"
  validates_uniqueness_of   :login

  after_validation          :crypt_password

  def after_save
    @new_password = false
  end 

  def before_create
    self.security_token = self.class.hashed("acamedias-#{Time.now}")
    self.token_expiry  = EXPIRE_AFTER_DAYS.days.from_now
  end
  
  def validate_password?
    @new_password
  end

  def self.hashed(str)
    return Digest::SHA1.hexdigest("acamedias--#{str}--")[0..39]
  end

  def crypt_password
    if @new_password
      self.salt = self.class.hashed("acamedias-#{Time.now}")
      self.salted_password = self.class.hashed(salt + self.class.hashed(@password))
    end
  end
  
public
  attr_accessor :new_password, :password, :password_confirmation
  alias password_alias= password=

  def initialize(attributes = nil)
    super
    unless self.id
      @new_password = true
    end
  end

  def password=(pass)
    @new_password = true
    self.password_alias = pass
  end

  def self.authenticate(login, password)
    begin
      u = find(:first, :conditions => ["login = ? AND verified = true AND deleted = 0", login])
      salted_password = self.hashed(u.salt + self.hashed(password))
      return u if salted_password == u.salted_password
      return nil
    rescue
      return nil
    end
  end
end
