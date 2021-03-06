class CreateSchools < ActiveRecord::Migration
  def self.up
    create_table :schools do |t|
      t.column :name,         :string,  :null => false
      t.column :description,  :text,    :null => false
      t.column :created_by,   :integer, :null => false
      t.column :domain,       :string,  :null => false
      t.timestamps
    end
    add_index :schools, :domain, :unique => true
    add_index :schools, :name
    add_index :schools, :created_by
  end

  def self.down
    drop_table :schools
  end
end
