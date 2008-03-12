class CreateCourseUsers < ActiveRecord::Migration
  def self.up
    create_table :course_users do |t|
      t.column :course_id,  :integer, :null => false
      t.column :user_id,    :integer, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :course_users
  end
end
