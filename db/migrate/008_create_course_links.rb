class CreateCourseLinks < ActiveRecord::Migration
  def self.up
    create_table :course_links do |t|
      t.column :course_id,    :integer, :null => false
      t.column :school_id,    :integer, :null => false
      t.column :created_by,   :integer, :null => false
      t.column :url,          :string,  :null => false
      t.column :degree_id,    :integer, :default => nil
      t.column :offered_year, :integer, :default => nil
      t.column :assignments_url,    :string, :default => nil
      t.column :lectures_url,       :string, :default => nil
      t.column :video_lectures_url, :string, :default => nil
      t.timestamps
    end
    add_index :course_links, :course_id
    add_index :course_links, :school_id
    add_index :course_links, :created_by
    add_index :course_links, :degree_id
  end

  def self.down
    drop_table :course_links
  end
end
