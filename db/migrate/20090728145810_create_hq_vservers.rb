class CreateHqVservers < ActiveRecord::Migration
  def self.up
    create_table :hq_vservers do |t|
      t.integer :hq_server_id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :hq_vservers
  end
end
