class CreateHqApps < ActiveRecord::Migration
  def self.up
    create_table :hq_apps do |t|
      t.integer :hq_system_id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :hq_apps
  end
end
