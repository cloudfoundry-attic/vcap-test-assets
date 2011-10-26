class CreateSpooges < ActiveRecord::Migration
  def self.up
    create_table :spooges do |t|
      t.string :name
      t.string :email
      t.datetime :touch
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :spooges
  end
end
