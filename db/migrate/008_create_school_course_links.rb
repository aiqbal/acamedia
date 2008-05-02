class CreateSchoolCourseLinks < ActiveRecord::Migration
  def self.up
    create_table :school_course_links do |t|
      t.column :course_id,    :integer, :null => false
      t.column :school_id,    :integer, :null => false
      t.column :created_by,   :integer, :null => false
      t.column :url,          :string,  :null => false
      t.column :degree_id,    :integer, :default => nil
      t.column :offered_year, :integer, :default => nil
      t.timestamps
    end
    add_index :school_course_links, :course_id
    add_index :school_course_links, :school_id
    add_index :school_course_links, :created_by
    add_index :school_course_links, :degree_id
  end

  def self.down
    drop_table :school_course_links
  end
end
