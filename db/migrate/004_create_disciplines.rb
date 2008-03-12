class CreateDisciplines < ActiveRecord::Migration
  def self.up
    create_table :disciplines do |t|
      t.column :name,         :string,  :null => false
      t.column :description,  :text,    :null => false
      t.column :created_by,   :integer, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :disciplines
  end
end
