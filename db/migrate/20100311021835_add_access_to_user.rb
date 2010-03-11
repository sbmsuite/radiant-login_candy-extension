class AddAccessToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :access, :string, :default => 'front'
  end

  def self.down
    remove_column :users, :access
  end
end
