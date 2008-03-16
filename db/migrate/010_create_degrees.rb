class CreateDegrees < ActiveRecord::Migration
  def self.up
    create_table :degrees do |t|
      t.column :name,           :string,  :null => false
      t.column :short_name,     :string,  :null => false
      t.column :level,          :string,  :default => nil
      t.column :discipline_id,  :integer, :default => nil
      t.column :created_by,     :integer, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :degrees
  end
end
