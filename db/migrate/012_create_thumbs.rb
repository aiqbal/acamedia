class CreateThumbs < ActiveRecord::Migration
  def self.up
    create_table :thumbs do |t|
      t.column  :thumb_type,     :string,    :null => false,    :limit => 10
      t.column  :thumb_class,    :string,    :null => false,    :limit => 100
      t.column  :ref_id,         :integer,   :null => false
      t.column  :user_id,        :integer,   :null => false
      t.timestamps
    end
    add_index :thumbs, [:ref_id, :thumb_class]
    add_index :thumbs, [:ref_id, :thumb_class, :user_id]
  end

  def self.down
    drop_table :thumbs
  end
end
