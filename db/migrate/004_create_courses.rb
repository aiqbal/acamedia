class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.column :name,         :string,  :null => false
      t.column :description,  :text,    :null => false
      t.column :created_by,   :integer, :null => false
      t.column :discipline_id,:integer, :null => false
      t.timestamps
    end
    add_index :courses, :name, :unique => true 
    add_index :courses, :created_by
  end

  def self.down
    drop_table :courses
  end
end
