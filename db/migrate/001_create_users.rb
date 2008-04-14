class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column  :login,           :string,    :null => false,   :limit => 80
      t.column  :salted_password, :string,    :null => false,   :limit => 40 
      t.column  :firstname,       :string,                      :limit => 40
      t.column  :lastname,        :string,                      :limit => 40
      t.column  :salt,            :string,    :null => false,   :limit => 40
      t.column  :verified,        :boolean,   :default => 0
      t.column  :role,            :string,    :default => nil,  :limit => 40
      t.column  :security_token,  :string,    :null => false,   :limit => 40
      t.column  :token_expiry,    :datetime,  :default => nil
      t.column  :logged_in_at,    :datetime,  :default => nil
      t.column  :deleted,         :boolean,   :default => 0
      t.column  :delete_after,    :datetime,  :default => nil
      t.timestamps
    end
    add_index :users, :login, :unique => true
  end

  def self.down
    drop_table :users
  end
end
