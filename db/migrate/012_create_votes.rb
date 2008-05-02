class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.column :ref_class,  :string,    :null => false
      t.column :ref_id,     :integer,   :null => false
      t.column :agreement,  :integer,   :null => false, :default => 0, :limit => 2
      t.column :user_id,    :integer,   :null => false
      t.timestamps
    end
    add_index :votes, [:ref_id, :ref_class]
    add_index :votes, [:ref_id, :ref_class, :user_id]
    add_index :votes, [:user_id]

    create_table :votes_summaries do |t|
      t.column :ref_class,    :string,  :null => false
      t.column :ref_id,       :integer, :null => false
      t.column :yes,          :integer, :null => false, :default => 0
      t.column :no,           :integer, :null => false, :default => 0
      t.column :lock_version, :integer, :default => 0
      t.timestamps
    end
    add_index :votes_summaries, [:ref_id, :ref_class]

  end

  def self.down
    drop_table :votes
    drop_table :votes_summaries
  end
end
