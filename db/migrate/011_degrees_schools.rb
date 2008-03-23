class DegreesSchools < ActiveRecord::Migration
  def self.up
    create_table :degrees_schools, :id => false do |t|
      t.column :degree_id,  :integer, :null => false
      t.column :school_id,  :integer, :null => false
      t.timestamps
    end
    add_index :degrees_schools, :school_id
    add_index :degrees_schools, :degree_id
  end

  def self.down
    drop_table :degrees_schools
  end
end
