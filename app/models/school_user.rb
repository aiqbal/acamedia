class SchoolUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :school
end
