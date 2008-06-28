class CreateAlternateNames < ActiveRecord::Migration
  def self.up
    create_table :alternate_names do |t|
      t.column  :ref_class,       :string,  :null =>  false
      t.column  :ref_id,          :integer, :null =>  false
      t.column  :user_id ,        :integer, :null =>  false
      t.column  :alternate_name,  :string,  :null =>  false
      t.timestamps
    end
    add_index :alternate_names, [:ref_id, :ref_class]
    add_index :alternate_names, [:ref_id, :ref_class, :user_id]
    add_index :alternate_names, [:user_id]
  end

  def self.down
    drop_table :alternate_names
  end
end
