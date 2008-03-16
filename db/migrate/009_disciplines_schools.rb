class DisciplinesSchools < ActiveRecord::Migration
  def self.up
    create_table :disciplines_schools, :id => false do |t|
      t.column :school_id,      :integer, :null => false
      t.column :discipline_id,  :integer, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :disciplines_schools
  end
end
