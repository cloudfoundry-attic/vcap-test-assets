class RenameMyColumnByHand < ActiveRecord::Migration
  def self.up
    rename_column :spooges, :touch, :touch_date
  end

  def self.down
  end
end
