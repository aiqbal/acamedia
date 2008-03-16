class DegreesSchools < ActiveRecord::Migration
  def self.up
    create_table :degrees_schools, :id => false do |t|
      t.column :degree_id,  :integer, :null => false
      t.column :school_id,  :integer, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :degrees_schools
  end
end
