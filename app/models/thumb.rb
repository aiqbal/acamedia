class Thumb < ActiveRecord::Base
  set_table_name "thumbs"
  belongs_to :user
end
