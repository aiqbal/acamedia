class CreateCourseLinks < ActiveRecord::Migration
  def self.up
    create_table :course_links do |t|
      t.column :course_id,    :integer, :null => false
      t.column :school_id,    :integer, :null => false
      t.column :created_by,   :integer, :null => false
      t.column :url,          :string,  :null => false
      t.column :level,        :string,  :default => nil
      t.column :offered_year, :integer,  :default => nil
      t.timestamps
    end
  end

  def self.down
    drop_table :course_links
  end
end
