class DisciplinesUsers < ActiveRecord::Migration
  def self.up
    create_table :disciplines_users, :id => false do |t|
      t.column :user_id,      :integer, :null => false
      t.column :discipline_id,:integer, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :disciplines_users
  end
end
