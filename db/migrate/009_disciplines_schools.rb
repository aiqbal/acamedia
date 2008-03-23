class DisciplinesSchools < ActiveRecord::Migration
  def self.up
    create_table :disciplines_schools, :id => false do |t|
      t.column :school_id,      :integer, :null => false
      t.column :discipline_id,  :integer, :null => false
      t.timestamps
    end
    add_index :disciplines_schools, :discipline_id
    add_index :disciplines_schools, :school_id
  end

  def self.down
    drop_table :disciplines_schools
  end
end
