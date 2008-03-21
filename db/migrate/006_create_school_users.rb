class CreateSchoolUsers < ActiveRecord::Migration
  def self.up
    create_table :school_users do |t|
      t.column :user_id,      :integer, :null => false
      t.column :school_id,    :integer, :null => false
      t.timestamps
    end
    add_index :school_users, :school_id
    add_index :school_users, :user_id
    add_index :school_users, [:user_id, :school_id]
  end

  def self.down
    drop_table :school_users
  end
end
