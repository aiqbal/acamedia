class CreateOnlineResources < ActiveRecord::Migration
  def self.up
    create_table :online_resources do |t|
      t.column  :ref_id,        :integer,   :null => false
      t.column  :ref_class,     :string,    :null => false,    :limit => 100
      t.column  :user_id,       :integer,   :null => false
      t.column  :resource_type, :string,    :null => false,    :limit => 50
      t.column  :url,           :string,    :null => false
      t.column  :title,         :string
      t.column  :description,   :string
      t.timestamps
    end
    add_index :online_resources, [:ref_id, :ref_class]
    add_index :online_resources, [:ref_id, :ref_class, :user_id]
  end

  def self.down
    drop_table :online_resources
  end
end
