class CreateOnlineResources < ActiveRecord::Migration
  def self.up
    create_table :online_resources do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :online_resources
  end
end
