class CreateHqNetconnections < ActiveRecord::Migration
  def self.up
    create_table :hq_netconnections do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :hq_netconnections
  end
end
