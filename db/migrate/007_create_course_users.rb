class CreateCourseUsers < ActiveRecord::Migration
  def self.up
    create_table :course_users do |t|
      t.column :course_id,  :integer, :null => false
      t.column :user_id,    :integer, :null => false
      t.timestamps
    end
    add_index :course_users, :course_id
    add_index :course_users, :user_id
    add_index :course_users, [:user_id, :course_id]
  end

  def self.down
    drop_table :course_users
  end
end
